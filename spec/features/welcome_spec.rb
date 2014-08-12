require 'rails_helper'

feature 'about page' do
  scenario 'user can see about page' do
    visit '/'
    click_link 'About'
    expect(page).to have_content 'Product sorting'
  end
end

