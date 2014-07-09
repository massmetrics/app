require 'rails_helper'

describe PriceLog do
  it 'Can add a new price, given a product' do
    item = Product.create_from_sku("B0047Y6I24")
    new_log = PriceLog.create(price: item.current_price, product: item)
    expect(new_log.price).to eq('5495')
    expect(new_log.created_at).to_not eq(nil)
    expect(new_log.product).to eq(item)
  end
end