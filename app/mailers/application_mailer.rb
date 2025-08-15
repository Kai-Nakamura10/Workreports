class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_FROM') # ← SendGridで認証済みアドレス
  layout 'mailer'
end
