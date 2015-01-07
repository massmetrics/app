require 'rails_helper'

describe PriceLog do
  it 'Can add a new price, given a product' do
    product = ObjectCreation.create_product
    new_log = PriceLog.create(price: product.current_price, product: product)

    expect(new_log.price).to eq(product.current_price)
    expect(new_log.created_at).to_not eq(nil)
    expect(new_log.product).to eq(product)
  end

  it 'calculates products average price after price log creation' do
    product = ObjectCreation.create_product
    new_log = PriceLog.create!(price: product.current_price, product: product)
    expect(product.current_average_price).to eq(new_log.price.to_i)
    new_log2 = PriceLog.create!(price: (product.current_price.to_i/2).to_s, product: product, created_at: 2.day.ago)
    expect(product.current_average_price).to eq(3842)
  end


end