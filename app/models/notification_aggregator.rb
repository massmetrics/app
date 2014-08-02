class NotificationAggregator
  def self.aggregate
    User.all.map do |user|
       evaluate(user)
    end.compact
  end

  def self.evaluate(user)
    products = []
    user.notifications.map do |notification|
      if notification.send_notification?
        products << notification.my_product.product
        update_notification(notification)
      end
    end
    unless products.empty?
      [user, products]
    end
  end

  def self.update_notification(notification)
    notification.update!(notification_date: Time.now)
  end
end
