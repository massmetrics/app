require "rails_helper"

feature "Homepage" do
  scenario "It the price of each item and the percent discount" do
    product = ObjectCreation.create_product(current_price: "1000")
    ObjectCreation.create_price_log(product: product, price: "2000")
    ObjectCreation.create_price_log(product: product, price: "1000")

    visit '/'

    expect(page).to have_content(ProductCurrency.format_money(product.current_price))
    within "img" do
      expect(page).to have_xpath("//img[@src=\"#{product.large_image_url}\"]")
    end
    expect(page).to have_content NumberFormatter.format_percentage(product.percent_discount)[0]
  end
end
