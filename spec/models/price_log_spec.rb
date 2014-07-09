require 'rails_helper'

describe PriceLog do
  it 'Can add a new price, given a product' do
    product = ObjectCreation.create_product
    new_log = PriceLog.create(price: product.current_price, product: product)
    expect(new_log.price).to eq(product.current_price)
    expect(new_log.created_at).to_not eq(nil)
    expect(new_log.product).to eq(product)
  end
end