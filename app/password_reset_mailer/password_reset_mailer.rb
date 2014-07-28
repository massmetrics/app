class PasswordResetMailer < ActionMailer::Base
  default from: 'noreply@massmetrics.com'

  def reset_password_email(user)
    @user = user
    @url  = edit_password_reset_url(user.reset_password_token)
    mail(to: @user.email, subject: "Reset your Mass Metrics Password")
  end
end