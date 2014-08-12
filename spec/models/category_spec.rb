require 'rails_helper'

describe Category do

  it 'returns a list of all categories' do
    ObjectCreation.create_product_with_category({category: 'Protein'})
    product = Product.find_by_sku('12345')
    ObjectCreation.create_price_log(product: product)
    ObjectCreation.create_product_with_category({category: 'Pre-workout'}, {sku: 'product2'})
    product2 = Product.find_by_sku('product2')
    ObjectCreation.create_price_log(product: product2)
    ObjectCreation.create_product_with_category({category: 'Pre-workout'}, {sku: 'product3'})
    product3 = Product.find_by_sku('product3')
    ObjectCreation.create_price_log(product: product3)

    expect(Category.category_list).to match_array(['Protein', 'Pre-workout'])
  end

  it 'makes first letter of each word capital before creation' do
    protein = Category.create(category: 'protein')

    expect(protein.category).to eq('Protein')

    pre_workout = Category.create(category: 'pre workout')
    expect(pre_workout.category).to eq('Pre Workout')
  end
end