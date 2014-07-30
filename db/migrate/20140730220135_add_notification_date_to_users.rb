class AddNotificationDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notification_date, :datetime
  end
end
