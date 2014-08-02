require 'rails_helper'
describe NotificationAggregator do
  it 'aggregates notifications' do
    notification_1 = ObjectCreation.create_notification
    notification_2 = ObjectCreation.create_notification

    expect(notification_1.notification_date).to be_nil
    expect(notification_2.notification_date).to be_nil

    expect(NotificationAggregator.aggregate).to eq([[notification_1.user,[notification_1.my_product.product]], [notification_2.user,[notification_2.my_product.product]]])
    notification_1.reload
    notification_2.reload
    expect(notification_1.notification_date).to_not be_nil
    expect(notification_2.notification_date).to_not be_nil
  end
end