require 'rails_helper'

describe Product do
  it 'can add a new product from an SKU - Myotein Chocolate' do
    product = ObjectCreation.create_product(sku: "B0047Y6I24")
    expect(product.sku).to eq("B0047Y6I24")
    expect(product.valid?).to eq(true)
  end

  it 'wont create an item if sku is already in db' do
    product = ObjectCreation.create_product(sku: "B0047Y6I24")
    invalid_item = ObjectCreation.create_product(sku: product.sku)
    expect(invalid_item.valid?).to eq(false)
  end

  it "returns all price logs created within 5 days" do
    new_item = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: new_item, created_at: 1.day.ago)
    ObjectCreation.create_price_log(product: new_item, created_at: 2.day.ago)
    ObjectCreation.create_price_log(product: new_item, created_at: 5.day.ago + 100)
    excluded_log = ObjectCreation.create_price_log(product: new_item, created_at: 6.day.ago)

    expect(new_item.get_price_logs(5).length).to eq(3)
    expect(new_item.get_price_logs(5)).not_to include(excluded_log)

  end

  it 'converts price logs to a hash' do
    new_time = Time.local(2014, 6, 1, 12, 0, 0)
    Timecop.freeze(new_time) do
      new_item = ObjectCreation.create_product
      ObjectCreation.create_price_log(product: new_item, created_at: "Fri, 04 Jul 2014 22:24:46 UTC +00:00")
      ObjectCreation.create_price_log(product: new_item, created_at: "Mon, 07 Jul 2014 22:23:06 UTC +00:00")
      expect(new_item.price_log_hash(7)).to eq({"2014-07-07 22:23:06 UTC"=>"1.0", "2014-07-04 22:24:46 UTC"=>"1.0"})
    end
  end

  it "gets the average of all of the price logs for a given product" do
    new_item = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: new_item, price: "1000")
    ObjectCreation.create_price_log(product: new_item, price: "2000")

    expect(new_item.average_price(30)).to eq(1500)
  end

  it "returns all products and their average prices over a given period" do
    new_item = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: new_item, price: "1000")
    ObjectCreation.create_price_log(product: new_item, price: "2000")
    new_item2 = ObjectCreation.create_product(sku: "item_2")
    ObjectCreation.create_price_log(product: new_item2, price: "5000")
    ObjectCreation.create_price_log(product: new_item2, price: "10000")


    expect(Product.averages).to eq([[new_item, 1500],[new_item2, 7500]])
  end

  it "returns the best products buy value " do
    new_item = ObjectCreation.create_product(current_price: "1000")
    ObjectCreation.create_price_log(product: new_item, price: "2000")
    ObjectCreation.create_price_log(product: new_item, price: "1000")
    new_item2 = ObjectCreation.create_product(current_price: "1700", sku: "item_2")
    ObjectCreation.create_price_log(product: new_item2, price: "2000")
    ObjectCreation.create_price_log(product: new_item2, price: "1000")
    expect(Product.percent_discounts(2)).to eq([new_item,new_item2])
  end

  it "returns the discount for a single product" do
    new_item = ObjectCreation.create_product(current_price: "1000")
    ObjectCreation.create_price_log(product: new_item, price: "2000")
    ObjectCreation.create_price_log(product: new_item, price: "1000")

    expect(new_item.percent_discount).to eq(0.3333333333333333)
  end
end