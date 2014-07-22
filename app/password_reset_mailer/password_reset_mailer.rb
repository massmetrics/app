class PasswordResetMailer < ActionMailer::Base
  default from: 'Userserices@massmetrics.com'

  def welcome_email(user)
    @user = user
    @url  = "#{root_url}/password_resets?auth_token=#{@user.reset_password_token}"
    mail(to: @user.email, subject: "Password Reset")
  end
end