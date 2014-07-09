require "rails_helper"

feature "Homepage" do
  scenario "It displays a welcome message on homepage" do
    item = Product.create_from_sku("B0047Y6I24")
    visit '/'
    expect(page).to have_content(item.title)
  end
end
