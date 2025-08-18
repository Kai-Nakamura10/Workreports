class ReportMailer < ApplicationMailer
  # 送信元アドレスの設定（Verified済みのアドレスを環境変数で取得）
  default from: ENV.fetch('MAIL_FROM')

  def report_notification(report, to:, cc: nil, bcc: nil, subject:, body: nil)
    @report = report
    @body = body

    # PDFを生成してメールに添付
    pdf = generate_pdf(@report)

    # 添付ファイルとしてPDFを追加
    attachments["report_#{report.id}.pdf"] = { mime_type: 'application/pdf', content: pdf }

    # メール送信
    mail(to: to, cc: cc, bcc: bcc, subject: subject)
  end

  private

  def generate_pdf(report)
    # フォントファイルのパス
    normal_font_path = Rails.root.join("app/assets/fonts/NotoSansJP-Regular.ttf")
    bold_font_path = Rails.root.join("app/assets/fonts/NotoSansJP-Bold.ttf")

    # PrawnでPDFを生成
    Prawn::Document.new do |pdf|
      # フォントファミリーの登録
      pdf.font_families.update('NotoSansJP' => {
        normal: normal_font_path,
        bold: bold_font_path
      })

      # フォントを指定してテキストを追加
      pdf.font('NotoSansJP', style: :bold)  # boldスタイルを使用
      pdf.text "日報 - #{report.title}", size: 24, style: :bold
      pdf.move_down 10

      pdf.font('NotoSansJP', style: :normal)  # normalスタイルを使用
      pdf.text report.body, size: 12
      pdf.move_down 10

      # italic スタイルを省略
      pdf.font('NotoSansJP', style: :normal)  # italicを省略してnormalを使用
      pdf.text "作成日時: #{report.created_at.strftime('%Y年%m月%d日 %H:%M')}", size: 10, style: :normal
    end.render
  end
end
