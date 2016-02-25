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

      expect(new_item.price_log_hash).to eq({'Jul 4' => '1.00', 'Jul 7' => '1.00'})
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

  it 'returns 0 if no price logs exist' do
    new_item = ObjectCreation.create_product(current_price: '1000')

    expect(new_item.percent_discount).to eq(0)
  end

  it 'returns the best products by value' do
    new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_2')
    ObjectCreation.create_price_log(product: new_item, price: '2000')
    ObjectCreation.create_price_log(product: new_item, price: '1000')
    new_item2 = ObjectCreation.create_product(current_price: '1000')
    ObjectCreation.create_price_log(product: new_item2, price: '2000')
    ObjectCreation.create_price_log(product: new_item2, price: '1000')

    expect(Product.percent_discounts(Product.all)).to eq([new_item2, new_item])
  end

  context 'categories' do
    it 'can add a category to a product' do
      ObjectCreation.create_category
      ObjectCreation.create_category(name:'pill')
      ObjectCreation.create_category(name: 'vitamin')
      new_item = ObjectCreation.create_product(current_price: '1000')
      new_item.add_categories(['Protein'])

      new_item.reload
      expect(new_item.categories.map { |cat| cat.name }).to include('Protein')

      new_item.add_categories(["Pill", "Protein", "Vitamin"])
      new_item.reload

      expect(new_item.categories.map { |cat| cat.name }).to match_array( ["Pill", "Protein", "Vitamin"])
    end

    it 'doesnt add duplicate categories to a product' do
      ObjectCreation.create_category
      new_item = ObjectCreation.create_product(current_price: '1000')
      new_item.add_categories(['Protein', 'protein'])
      new_item.reload
      expect(new_item.categories.map { |cat| cat.name }).to match_array(['Protein'])
    end

    it 'updates all categories for a product' do
      ObjectCreation.create_category
      ObjectCreation.create_category(name: 'pre workout')
      new_item = ObjectCreation.create_product(current_price: '1000')
      new_item.add_categories(['Protein'])
      new_item.reload
      new_item.update_categories(['Pre Workout'])
      new_item.reload

      expect(new_item.categories.map { |cat| cat.name }).to match_array(['Pre Workout'])
    end
  end

  it 'returns a list of products for a given category' do
    ObjectCreation.create_product_with_category({name: 'protein'}, {sku: '123'})
    ObjectCreation.create_product_with_category({name: 'pre workout'}, {sku: '1234'})
    ObjectCreation.create_product_with_category({name: 'protein'}, {sku: '12345'})
    first_product = Product.find_by_sku('123')
    second_product = Product.find_by_sku('12345')
    third_product = Product.find_by_sku('1234')

    expect(Product.get_products_for('Protein')).to match_array([first_product, second_product])
    expect(Product.get_products_for('Protein')).to_not include(third_product)
  end

  it 'returns the best products by value for a category up to the number requested' do
    protein = ObjectCreation.create_category
    new_item = ObjectCreation.create_product(current_price: '1700',sku: 'item_1')
    ProductCategory.create(product_id: new_item.id, category_id: protein.id)

    ObjectCreation.create_price_log(product: new_item, price: '2000')
    ObjectCreation.create_price_log(product: new_item, price: '1000')


    new_item2 = ObjectCreation.create_product(current_price: '1000', sku: 'item_2')
    ProductCategory.create(product_id: new_item2.id, category_id: protein.id)
    ObjectCreation.create_price_log(product: new_item2, price: '2000')
    ObjectCreation.create_price_log(product: new_item2, price: '1000')

    new_item3 = ObjectCreation.create_product_with_category({name: 'Pre-workout'},
                                                            {current_price: '1000', sku: 'item_3'}).product
    ObjectCreation.create_price_log(product: new_item3, price: '2000')
    ObjectCreation.create_price_log(product: new_item3, price: '1000')

    expect(Product.category_discounts('Protein', 2)).to eq([
                                                             [new_item2, new_item2.price_log_hash, new_item2.percent_discount],
                                                             [new_item, new_item.price_log_hash, new_item.percent_discount]
                                                           ])
  end

  it 'returns 0 of no price logs exist' do
    new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_1')

    expect(new_item.average_price).to eq(0)
  end

  context 'Price logs' do
    it 'gets the highest percentage off products along with the price log hash' do
      new_item = ObjectCreation.create_product(current_price: '1700', sku: 'item_2')
      ObjectCreation.create_price_log(product: new_item, price: '2000')
      ObjectCreation.create_price_log(product: new_item, price: '1000')
      new_item2 = ObjectCreation.create_product(current_price: '1000')
      ObjectCreation.create_price_log(product: new_item2, price: '2000')
      ObjectCreation.create_price_log(product: new_item2, price: '1000')

      expect(Product.top_products_with_logs(Product.all)).to eq([
                                                        [new_item2, new_item2.price_log_hash, new_item2.percent_discount],
                                                        [new_item, new_item.price_log_hash, new_item.percent_discount]
                                                      ])
    end
  end
end
