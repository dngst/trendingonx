# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name(ENV.fetch('SMTP_USERNAME', nil), 'ToX Notification')
  layout 'mailer'
end
