require 'rails_helper'

describe User do
  context 'validations' do
    it 'validates password confirmation' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'sue@example.com', password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    it 'validates uniqueness of email' do
      valid_user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid

    end

    it 'validates presence of password' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'sue@example.com', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    it 'validates presence of email' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new( password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    it 'validates password and password confirmation match' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email:'joe@example.com', password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end
  end

  it 'defaults role to user' do
    user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
    expect(user.role).to eq('user')
  end

  it 'checks the users role' do
    user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
    expect(user.role?('admin')).to eq(false)
    expect(user.role?('user')).to eq(true)
    admin_user = User.create(email: 'jon@example.com', password: 'password', password_confirmation: 'password', role: 'admin')
    expect(admin_user.role?('admin')).to eq(true)
    expect(admin_user.role?('user')).to eq(false)
  end
end

