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

    it 'validates email is an email' do
      valid_user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'why you mad?', password: 'password', password_confirmation: 'password')

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
      invalid_user = User.new(password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end

    it 'validates password and password confirmation match' do
      valid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password')
      invalid_user = User.new(email: 'joe@example.com', password: 'password', password_confirmation: 'password confirmation')

      expect(valid_user).to be_valid
      expect(invalid_user).to be_invalid
    end
  end

  it 'defaults role to user' do
    user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')

    expect(user.role).to eq(:user)
  end

  it 'checks the users role' do
    user = User.create(email: 'joe@example.com', password: 'password', password_confirmation: 'password')

    expect(user.role?(:admin)).to eq(false)
    expect(user.role?(:user)).to eq(true)

    admin_user = User.create(email: 'jon@example.com', password: 'password', password_confirmation: 'password', role: 'admin')

    expect(admin_user.role?(:admin)).to eq(true)
    expect(admin_user.role?(:user)).to eq(false)
  end

  it 'returns true if a user tracked an item' do
    user = ObjectCreation.create_user
    product = ObjectCreation.create_product
    other_user = ObjectCreation.create_user(email: 't@t.com')
    MyProduct.create(user: user, product: product)
    user.reload
    other_user.reload
    expect(other_user.tracked?(product)).to eq(false)
    expect(user.tracked?(product)).to eq(true)
  end

  it 'returns all of the products a user has tracked that have reached the threshold' do
    user = ObjectCreation.create_user
    product = ObjectCreation.create_product(current_price: '80')
    ObjectCreation.create_price_log(product: product, price: '100')
    product2 = ObjectCreation.create_product(current_price: '80', sku: '2312')
    ObjectCreation.create_price_log(product: product2, price: '100')
    my_p = MyProduct.create(user: user, product: product)
    my_p2 = MyProduct.create(user: user, product: product2)
    MyProductsNotification.create(my_product: my_p, discount: 10.0)
    MyProductsNotification.create(my_product: my_p2, discount: 15.0)
    expect(user.notifications).to eq([product, product2])
  end

  it 'returns false if user received notification in the last 7 days' do
    user = ObjectCreation.create_user
    expect(user.send_notification?).to eq(true)
    user.update(notification_date: 5.day.ago)
    user.reload
    expect(user.send_notification?).to eq(false)
  end
end

