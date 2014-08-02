class NotificationAggregator
  def self.aggregate
    output = []
    User.all.each do |user|
      products = []
      user.notifications.each do |notification|
        if notification.send_notification?
          products << notification.my_product.product
          notification.update!(notification_date: Time.now)
        end
      end
      unless products.empty?
        output << [user, products]
      end
    end
    output
  end
end
