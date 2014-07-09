require 'rails_helper'

describe Product do
  it 'can add a new product from an SKU - Myotein Chocolate' do
    item = Product.create_from_sku("B0047Y6I24")
    expect(item.sku).to eq("B0047Y6I24")
    expect(item.valid?).to eq(true)
  end

  it 'wont create an item if sku is already in db' do
    item = Product.create_from_sku("B0047Y6I24")
    invalid_item = Product.create_from_sku("B0047Y6I24")
    expect(invalid_item.valid?).to eq(false)
  end
end