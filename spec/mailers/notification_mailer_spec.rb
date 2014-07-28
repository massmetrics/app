require 'rails_helper'

describe NotificationMailer do


  describe 'message when user is created' do
    let(:user) {ObjectCreation.create_user}
    let(:product) {ObjectCreation.create_product}
    let(:message) { NotificationMailer.notification_email(user, product) }


    it 'comes from the proper user' do

      expect(message.from).to eq ['service@massmetrics.com']
    end

    it 'goes to the proper user' do

      expect(message.to).to eq [user.email]
    end

    it 'has the proper subject' do

      expect(message.subject).to eq 'Your item has reached the target discount percentage!'
    end
  end
end