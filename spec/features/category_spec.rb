require 'rails_helper'

feature 'homepage' do
  scenario 'has a link to each category and to each product' do
    category_1 = ObjectCreation.create_product_with_category({category: 'Protein'})
    product = Product.find_by_sku('12345')
    ObjectCreation.create_price_log(product: product)
    category_2 = ObjectCreation.create_product_with_category({category: 'Pre-workout'}, {sku: 'product2'})
    product2 = Product.find_by_sku('product2')
    ObjectCreation.create_price_log(product: product2)


    visit '/'
    click_link 'Browse'

    expect(page).to have_content category_1.category
    expect(page).to have_content category_2.category

    click_on category_1.category

    expect(page).to have_content product.title

    click_on product.title

    expect(page).to have_content('Features:')
  end
end