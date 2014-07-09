require 'rails_helper'

describe Product do
  before do
    @product = ObjectCreation.create_product(sku: "B0047Y6I24")
  end
  it 'can add a new product from an SKU - Myotein Chocolate' do
    expect(@product.sku).to eq("B0047Y6I24")
    expect(@product.valid?).to eq(true)
  end

  it 'wont create an item if sku is already in db' do
    invalid_item = ObjectCreation.create_product(sku: @product.sku)
    expect(invalid_item.valid?).to eq(false)
  end

  it "returns all price logs created within 5 days" do
    new_item = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: new_item, created_at: 1.day.ago)
    ObjectCreation.create_price_log(product: new_item, created_at: 2.day.ago)
    ObjectCreation.create_price_log(product: new_item, created_at: 5.day.ago + 100)
    excluded_log = ObjectCreation.create_price_log(product: new_item, created_at: 6.day.ago)

    expect(new_item.get_prices(5).length).to eq(3)
    expect(new_item.get_prices(5)).not_to include(excluded_log)
  end
end