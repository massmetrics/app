require 'rails_helper'

describe MyProductsNotification do

  context 'validations' do
    it 'is invalid when a discount is 0 ' do
      valid_discount = MyProductsNotification.new(discount: '50.0')
      invalid_discount = MyProductsNotification.new(discount: '0')

      expect(invalid_discount).to_not be_valid
      expect(valid_discount).to be_valid
    end

    it 'is invalid when discount is greater than or equal to 100' do
      invalid_discount2 = MyProductsNotification.new(discount: '101')
      invalid_discount = MyProductsNotification.new(discount: '100')

      expect(invalid_discount).to_not be_valid
      expect(invalid_discount2).to_not be_valid
    end
  end

  it 'returns false if product notification was sent in the last 7 days' do
    notification = ObjectCreation.create_notification
    expect(notification.send_notification?).to eq(true)
    notification.update(notification_date: 5.day.ago)
    notification.reload
    expect(notification.send_notification?).to eq(false)
  end

  it 'updates token for all notifications from a given array' do
    notification1 = ObjectCreation.create_notification
    notification2 = ObjectCreation.create_notification
    MyProductsNotification.update_notifications([notification1,notification2])

    expect(notification1.notification_date).to_not be_nil
    expect(notification2.notification_date).to_not be_nil
  end
end
