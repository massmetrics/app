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

  it 'converts price logs to a hash' do
    new_time = Time.local(2014, 6, 1, 12, 0, 0)
    Timecop.freeze(new_time) do
      new_item = ObjectCreation.create_product
      ObjectCreation.create_price_log(product: new_item, created_at: "Fri, 04 Jul 2014 22:24:46 UTC +00:00")
      ObjectCreation.create_price_log(product: new_item, created_at: "Mon, 07 Jul 2014 22:23:06 UTC +00:00")
      expect(new_item.price_log_hash(7)).to eq({"2014-07-07 22:23:06 UTC"=>"100", "2014-07-04 22:24:46 UTC"=>"100"})
    end
  end
end