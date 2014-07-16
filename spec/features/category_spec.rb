require 'rails_helper'

feature 'homepage' do
  before do
   @category_1 = Category.create(category: 'Protein')
   @category_2 = Category.create(category: 'Pre workout')
  end
  scenario 'has a link to each category' do
    visit '/'
    click_link 'Browse'
    expect(page).to have_content @category_1.category
    expect(page).to have_content @category_2.category
  end
end