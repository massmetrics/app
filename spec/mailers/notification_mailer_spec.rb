require 'spec_helper'

describe NotificationMailer do
  before do
    @user = ObjectCreation.create_user
    @product = ObjectCreation.create_product
  end

  describe 'message when user is created' do
    let(:message) { NotificationMailer.notification_email(@user, @product) }


    it 'comes from the proper user' do

      expect(message.from).to eq ['service@massmetrics.com']
    end

    it 'goes to the proper user' do

      expect(message.to).to eq [@user.email]
    end

    it 'has the proper subject' do

      expect(message.subject).to eq 'Your item has reached the target discount percentage!'
    end
  end
end