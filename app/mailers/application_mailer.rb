# app/mailers/application_mailer.rb
class ApplicationMailer < ActionMailer::Base
  default from: -> { ENV['MAIL_FROM'] }  # ← 送信時に読む
  layout 'mailer'
end
