class MyProductsNotification < ActiveRecord::Base
  belongs_to :my_product
  has_one :user, through: :my_product
  before_create :string_to_float
  validates :discount, numericality: { greater_than: 0, less_than: 100, message: 'is invalid.' }

  def send_notification?
    send = true
    if notification_date && notification_date > 7.days.ago
      send = false
    end
    send
  end

  def self.update_notifications(notifications_array)
    notifications_array.each do |notification|
      notification.update(notification_date: Time.now)
    end
  end

  private
  def string_to_float
    self.discount = '%.2f' % (self.discount || 0)
  end
end