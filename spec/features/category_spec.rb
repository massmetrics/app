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

    first(:link, product.title).click

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

  context 'pagination' do
    feature 'when there are more than 10 products' do
      before do
        11.times do
          ObjectCreation.create_product_with_product_category({category: {name: "Protein"}, product: {sku: rand(1000000)}})
          ObjectCreation.create_price_log
        end
      end
      context 'on the home page' do
        scenario 'i can click on the next button to see more products' do
          visit root_path
          first(:link, "Next ›").click
          expect(page).to have_link('‹ Prev')
          expect(page).to have_link('« First')
          first(:link, "1").click
          expect(page).to have_link("Next ›")
          expect(page).to have_link("Last »")
          first(:link, "Last »").click
          expect(page).to have_link('‹ Prev')
          expect(page).to have_link('« First')
        end
      end

      context 'on a category page' do
        scenario 'i can click on the next button to see more products' do
          visit category_path('Protein')
          first(:link, "Next ›").click
          expect(page).to have_link('‹ Prev')
          expect(page).to have_link('« First')
          first(:link, "1").click
          expect(page).to have_link("Next ›")
          expect(page).to have_link("Last »")
          first(:link, "Last »").click
          expect(page).to have_link('‹ Prev')
          expect(page).to have_link('« First')
        end
      end
    end
  end

end