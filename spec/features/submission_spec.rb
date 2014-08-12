require 'rails_helper'

feature 'Submit an SKU and category' do
  scenario 'allows a user to submit a sku' do
    visit '/'
    click_on 'Suggest a product'
    fill_in 'submission[sku]', with: 'B0031JK96C'
    fill_in 'submission[category]', with: 'protein'
    click_on 'Suggest product'

    expect(page).to have_content('Thank you for your submission, it will be reviewed shortly')
  end

  scenario 'renders the new page with errors if an invalid sku is entered' do
    visit '/'
    click_on 'Suggest a product'
    fill_in 'submission[sku]', with: 'stuff'
    fill_in 'submission[category]', with: 'protein'
    click_on 'Suggest product'

    expect(page).to have_content 'Invalid SKU'
  end

  scenario 'User can get help suggesting a product' do
    visit '/'
    click_on 'Suggest a product'
    click_link 'Help'

    expect(page).to have_content 'Product sorting'
  end
end