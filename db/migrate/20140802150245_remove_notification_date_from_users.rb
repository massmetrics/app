class RemoveNotificationDateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :notification_date
  end
end
