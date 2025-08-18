module Reports
  class EmailsController < ApplicationController
    before_action :require_login           # 認証を使っているなら
    before_action :set_report              # ネストされた :report_id から読み込む

    # メール作成フォーム（既定値を日報から自動入力）
    def new
      @to      = params[:to]      || current_user&.email
      @cc      = params[:cc]
      @bcc     = params[:bcc]
      @subject = params[:subject] || "【日報】#{@report.title}"
      @body    = params[:body]    || default_body(@report)
    end

    # 送信処理（public アクションにする）
    def create
      p = email_params

      # PDFを生成してメールを送信
      ReportMailer.report_notification(
        @report,
        to:      p[:to],
        cc:      p[:cc],
        bcc:     p[:bcc],
        subject: p[:subject],
        body:    p[:body]
      ).deliver_now

      redirect_to reports_path, notice: 'メールを送信しました。'
    end

    private

    # /reports/:report_id/emails/... の :report_id から対象日報を取得
    def set_report
      @report = current_user.reports.find(params[:report_id])
    end

    # Strong Parameters
    def email_params
      params.require(:email).permit(:to, :cc, :bcc, :subject, :body)
    end

    # 既定の本文（一覧→メール作成で最初に入っているテキスト）
    def default_body(report)
      <<~TEXT
        #{report.title}

        #{report.body}

        作成日時: #{report.created_at.strftime('%Y年%m月%d日 %H:%M')}
      TEXT
    end
  end
end
