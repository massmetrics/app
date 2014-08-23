require 'rails_helper'

describe Category do

  it 'returns a list of all categories' do
    protein = ObjectCreation.create_category
    product1 = ObjectCreation.create_product
    ObjectCreation.create_price_log(product: product1)
    ProductCategory.create(product_id: product1.id, category_id: protein.id)

    ObjectCreation.create_product_with_category({category: 'Pre-workout'}, {sku: 'product2'})
    product2 = Product.find_by_sku('product2')
    ObjectCreation.create_price_log(product: product2)

    product3 = ObjectCreation.create_product(sku: 'product3')
    ProductCategory.create(product_id: product3.id, category_id: protein.id)
    ObjectCreation.create_price_log(product: product3)

    category_array = Category.all.map{|cat|cat.category}

    expect(category_array).to match_array(['Protein', 'Pre-workout'])
  end

  it 'makes first letter of each word capital before creation' do
    protein = Category.create(category: 'protein')

    expect(protein.category).to eq('Protein')

    pre_workout = Category.create(category: 'pre workout')
    expect(pre_workout.category).to eq('Pre Workout')
  end
end