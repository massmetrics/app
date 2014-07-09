require 'rails_helper'

describe Product do
  it 'can add a new product from an SKU - Myotein Chocolate' do
    item = Product.create_from_sku("B0047Y6I24")
    expect(item.sku).to eq("B0047Y6I24")
  end
end