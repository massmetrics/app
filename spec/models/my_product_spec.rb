require 'rails_helper'

describe MyProduct do
  before do
    @user = ObjectCreation.create_user
    @product = ObjectCreation.create_product
    MyProduct.create(product: @product, user: @user)
  end
  context 'validations' do
    it 'throws an error if user is already tracking the item' do
      product = MyProduct.new(product: @product, user: @user)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq(['Product is already tracked'])
    end
  end
end