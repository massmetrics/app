require "rails_helper"

feature "Homepage" do
  scenario "It displays a welcome message on homepage" do
    item = Product.create_from_sku("B0047Y6I24")
    visit '/'
    expect(page).to have_content(ProductCurrency.format_money(item.current_price))
    within "img" do
      expect(page).to have_xpath("//img[@src=\"#{item.large_image_url}\"]")
    end
  end
end
