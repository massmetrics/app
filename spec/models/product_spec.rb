require 'rails_helper'

describe Product do

  context 'validations' do
    it 'wont create an item if sku is already in db' do
      product = ObjectCreation.create_product(sku: 'B0047Y6I24')
      invalid_item = ObjectCreation.create_product(sku: product.sku)
      expect(invalid_item.valid?).to eq(false)
    end
  end

  it 'can add a new product from an SKU - Myotein Chocolate' do
    product = ObjectCreation.create_product(sku: 'B0047Y6I24')
    expect(product.sku).to eq('B0047Y6I24')
    expect(product.valid?).to eq(true)
  end


  it 'returns all price logs created within 5 days' do
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
      ObjectCreation.create_price_log(product: new_item, created_at: 'Fri, 04 Jul 2014 22:24:46 UTC +00:00')
      ObjectCreation.create_price_log(product: new_item, created_at: 'Mon, 07 Jul 2014 22:23:06 UTC +00:00')
      expect(new_item.price_log_hash(7)).to eq({'2014-07-07 22:23:06 UTC' => '1.00', '2014-07-04 22:24:46 UTC' => '1.00'})
    end
  end

  it 'gets the average of all of the price logs for a given product' do
    new_item = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: new_item, price: '1000')
    ObjectCreation.create_price_log(product: new_item, price: '2000')

    expect(new_item.average_price(30)).to eq(1500)
  end

  it 'returns the discount for a single product' do
    new_item = ObjectCreation.create_product(current_price: '1000')
    ObjectCreation.create_price_log(product: new_item, price: '2000')
    ObjectCreation.create_price_log(product: new_item, price: '1000')

    expect(new_item.percent_discount).to eq(0.3333333333333333)
  end

  it 'returns the best products by value' do
    new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_2')
    ObjectCreation.create_price_log(product: new_item, price: '2000')
    ObjectCreation.create_price_log(product: new_item, price: '1000')
    new_item2 = ObjectCreation.create_product(current_price: '1000')
    ObjectCreation.create_price_log(product: new_item2, price: '2000')
    ObjectCreation.create_price_log(product: new_item2, price: '1000')

    expect(Product.percent_discounts(2)).to eq([new_item2, new_item])
  end

  it 'can add a category to a product' do
    new_item = ObjectCreation.create_product(current_price: '1000')
    new_item.add_categories(['Protein'])

    expect(new_item.categories.map { |cat| cat.category }).to include('Protein')
    new_item.add_categories(['Pill', 'blah'])
    new_item.reload
    expect(new_item.categories.map { |cat| cat.category }).to match_array(['Protein', 'Pill', 'blah'])
  end

  it 'returns a list of products for a given category' do
    ObjectCreation.create_product_with_category({category: 'protein'}, {sku: '123'})
    ObjectCreation.create_product_with_category({category: 'pre workout'}, {sku: '1234'})
    ObjectCreation.create_product_with_category({category: 'protein'}, {sku: '12345'})
    first_product = Product.find_by_sku('123')
    second_product = Product.find_by_sku('12345')
    third_product = Product.find_by_sku('1234')

    expect(Product.get_products_for('protein')).to match_array([first_product, second_product])
    expect(Product.get_products_for('protein')).to_not include(third_product)
  end

  it 'returns the best products by value for a category up to the number requested' do
    new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_1')
    ObjectCreation.create_price_log(product: new_item, price: '2000')
    ObjectCreation.create_price_log(product: new_item, price: '1000')
    new_item.add_categories(['protein'])

    new_item2 = ObjectCreation.create_product(current_price: '1000')
    ObjectCreation.create_price_log(product: new_item2, price: '2000')
    ObjectCreation.create_price_log(product: new_item2, price: '1000')
    new_item2.add_categories(['protein'])

    new_item3 = ObjectCreation.create_product(current_price: '1000', sku: 'item_3')
    ObjectCreation.create_price_log(product: new_item3, price: '2000')
    ObjectCreation.create_price_log(product: new_item3, price: '1000')
    new_item3.add_categories(['pre workout'])

    new_item4 = ObjectCreation.create_product(current_price: '1000')
    ObjectCreation.create_price_log(product: new_item4, price: '2000')
    ObjectCreation.create_price_log(product: new_item4, price: '1000')
    new_item4.add_categories(['protein'])

    expect(Product.category_discounts('protein', 2)).to eq([new_item2, new_item])
  end

  it 'returns 0 of no price logs exist' do
    new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_1')

    expect(new_item.average_price).to eq(0)
  end
end
