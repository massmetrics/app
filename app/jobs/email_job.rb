class EmailJob
  include SuckerPunch::Job

  def perform(user,products_array)
    NotificationMailer.notification_email(user,products_array).deliver
  end
end
