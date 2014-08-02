class NotificationAggregator
  def self.aggregate
    output = []
    User.all.each do |user|
      products = []
      if user.notifications.length > 0
        user.notifications.each do |my_product|
          notification = my_product.my_products_notification
          if notification.send_notification?
            products << my_product.product
            notification.update!(notification_date: Time.now)
          end
        end
        output << [user, products]
      end
    end
    output
  end
end
