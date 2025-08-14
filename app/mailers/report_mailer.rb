class ReportMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def report_notification(report, to:, cc: nil, bcc: nil, subject:, body: nil)
    @report = report
    mail(to: to, cc: cc, bcc: bcc, subject: subject)
  end
end
