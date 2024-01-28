# frozen_string_literal: true

class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.first
    user.send_reset_password_instructions
    token = user.reset_password_token
    Devise::Mailer.reset_password_instructions(user, token)
  end

  def password_change
    user = User.first
    Devise::Mailer.password_change(user)
  end

  def email_changed
    user = User.first
    Devise::Mailer.email_changed(user)
  end
end
