require "rails_helper"

feature "Homepage" do
  scenario "It displays a welcome message on homepage" do
    product = ObjectCreation.create_product
    visit '/'
    expect(page).to have_content(ProductCurrency.format_money(product.current_price))
    within "img" do
      expect(page).to have_xpath("//img[@src=\"#{product.large_image_url}\"]")
    end
  end
end
