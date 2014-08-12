require 'rails_helper'

feature 'Product' do
  scenario 'User can view product details' do
    ObjectCreation.create_product_with_category({category: 'Protein'})
    product = Product.find_by_sku('12345')
    ObjectCreation.create_price_log(product: product)

    visit category_index_path
    first('.title').click

    expect(page).to have_content product.title
    expect(page).to have_content(ProductCurrency.format_money(product.current_price))
    expect(page).to have_link('Protein')
    within 'img' do
      expect(page).to have_xpath("//img[@src=\"#{product.large_image_url}\"]")
    end
  end
end