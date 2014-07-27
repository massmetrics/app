class EmailJob
  include SuckerPunch::Job

  def perform(user,product)
    NotificationMailer.notification_email(user,product).deliver
  end
end
