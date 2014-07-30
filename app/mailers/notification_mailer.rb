class NotificationMailer < ActionMailer::Base
  default from: 'service@massmetrics.com'

  def notification_email(user, product)
    @user = user
    @product = product
    mail(to: user.email, subject: "Your item has reached the target discount percentage!")
  end
end