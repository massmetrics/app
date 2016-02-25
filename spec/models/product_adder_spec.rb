require 'rails_helper'

describe ProductAdder do
  it 'adds a category to an existing product' do
    VCR.use_cassette('features/admin/submission/add_category') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        product = ObjectCreation.create_product
        category = ObjectCreation.create_category
        ProductAdder.add_category([product.sku], [category.name])

        expect(product.categories).to include(category)
      end
    end
  end

  it 'Creates a category if none exists' do
    VCR.use_cassette('features/admin/submission/add_and_create_category') do |cassette|
      new_time = cassette.originally_recorded_at || Time.now
      Timecop.freeze(new_time) do
        product = ObjectCreation.create_product
        category_name = 'Protein'
        ProductAdder.add_category([product.sku], ['Protein'])

        expected = Category.find_by_name(category_name)
        expect(product.categories).to include(expected)
      end
    end
  end
end
