require 'rails_helper'

feature "Product" do
  scenario "User can view product details" do
    product = ObjectCreation.create_product

    visit '/'
    click_link "#title"
    expect(page).to have_content product.title
    expect(page).to have_content(ProductCurrency.format_money(product.current_price))

    within "img" do
      expect(page).to have_xpath("//img[@src=\"#{product.large_image_url}\"]")
    end
  end
end