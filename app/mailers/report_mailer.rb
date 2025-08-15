class ReportMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def report_notification(report, to:, cc: nil, bcc: nil, subject:, body: nil)
    @report = report
    mail(from: ENV.fetch('MAIL_FROM'), to: to, cc: cc, bcc: bcc, subject: subject)
  end
end
