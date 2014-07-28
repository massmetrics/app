require 'rails_helper'

describe PasswordResetMailer do


  describe 'message when user is created' do
    let(:user)  {ObjectCreation.create_user(:reset_password_token => '10')}
    let(:message) { PasswordResetMailer.reset_password_email(user) }


    it 'comes from the proper user' do

      expect(message.from).to eq ['noreply@massmetrics.com']
    end

    it 'goes to the proper user' do

      expect(message.to).to eq [user.email]
    end

    it 'has the proper subject' do

      expect(message.subject).to eq 'Reset your Mass Metrics Password'
    end
  end
end