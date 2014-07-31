class AddNotificationDateToMyProductNotifications < ActiveRecord::Migration
  def change
    add_column :my_products_notifications, :notification_date, :datetime

  end
end
