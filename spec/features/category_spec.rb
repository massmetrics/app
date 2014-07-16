require 'rails_helper'

feature 'homepage' do
  before do
    @category_1 = ObjectCreation.create_product_with_category({category: 'Protein'})
    @product = Product.last
    @category_2 = Category.create(category: 'Pre workout')
  end
  scenario 'has a link to each category' do
    visit '/'
    click_link 'Browse'
    expect(page).to have_content @category_1.category
    expect(page).to have_content @category_2.category
    click_on @category_1.category
    expect(page).to have_content @product.title
  end
end