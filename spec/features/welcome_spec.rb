require 'rails_helper'

feature 'about page' do
  scenario 'user can see about page' do
    visit '/'
    click_link 'About'

    within '#p-suggest' do
      click_link "Suggest a product"
    end

    expect(page).to have_button('Suggest product')
  end
end

