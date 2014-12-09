require 'rails_helper'

feature 'Index' do
  scenario 'has a link to each category and to each product' do
    category_1 = ObjectCreation.create_product_with_category({name: 'Protein'})
    product = Product.find_by_sku('12345')
    ObjectCreation.create_price_log(product: product)
    category_2 = ObjectCreation.create_product_with_category({name: 'Pre-workout'}, {sku: 'product2'})
    product2 = Product.find_by_sku('product2')
    ObjectCreation.create_price_log(product: product2)


    visit category_index_path
    click_link 'Browse'

    within '#category-header' do
      expect(page).to have_content('Best deals')
    end
    expect(page).to have_content category_1.category.name
    expect(page).to have_content category_2.category.name

    click_on category_1.category.name

    within '#category-header' do
      expect(page).to have_content(category_1.category.name)
    end

    expect(page).to have_content product.title

    click_on product.title

    expect(page).to have_content('Features:')
  end

  scenario 'Buy now button is displayed on category card' do
    category_1 = ObjectCreation.create_product_with_category({name: 'Protein'})
    product = Product.find_by_sku('12345')
    ObjectCreation.create_price_log(product: product)

    visit category_index_path
    click_link category_1.category.name

    expect(page).to have_link 'Buy now!'
  end

    scenario 'It shows the price of each item and the percent discount' do
      product = ObjectCreation.create_product(current_price: '1000')
      ObjectCreation.create_price_log(product: product, price: '2000')
      ObjectCreation.create_price_log(product: product, price: '1000')

      visit category_index_path

      expect(page).to have_content(ProductCurrency.format_money(product.current_price))
      expect(page).to have_content NumberFormatter.format_percentage(product.percent_discount)[0]
    end

end