class NotificationMailer < ActionMailer::Base
  default from: 'service@massmetrics.com'

  def notification_email(user, products_array)
    @user = user
    @products = products_array
    mail(to: @user.email, subject: "Your item has reached the target discount percentage!")
  end
end