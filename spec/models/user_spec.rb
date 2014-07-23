require 'rails_helper'

describe User do
  context 'validations' do
    it 'validates password confirmation' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'sue@example.com', password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    it 'validates presence of password' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'sue@example.com', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    
  end
end

