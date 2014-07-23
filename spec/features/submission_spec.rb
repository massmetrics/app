require 'rails_helper'

describe 'Submit an SKU and category' do
  it 'allows a user to submit an sku' do
    visit '/'
    click_on 'Suggest a product'
    fill_in 'submission[sku]', with: '12345'
    fill_in 'submission[category]', with: 'protein'
    click_on 'Suggest product'
    expect(page).to have_content('Thank you for your submission, it will be reviewed shortly')
  end
end