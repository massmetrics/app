require 'rails_helper'

feature 'My Products' do
  context 'managing my products' do
    before do
      @user = FeatureSupport.create_and_login_user
      @product = ObjectCreation.create_product
      MyProduct.create(user: @user, product: @product)
    end

    scenario 'User removes a product that they tracked' do
      visit user_path(@user)
      click_on 'Untrack'
      expect(page).to_not have_content(@product.title)
    end

    scenario 'User adds pricing threshold' do
      visit user_path(@user)
      fill_in 'my_products_notification[discount]', with: '15'
      click_on 'Save notification'
      expect(find_field('my_products_notification[discount]').value).to eq('15.0')
    end

    scenario 'User adds invalid discount' do
      visit user_path(@user)
      fill_in 'my_products_notification[discount]', with: '15asdf%'
      click_on 'Save notification'
      expect(page).to have_content('Invalid format for discount')
    end

    scenario 'User can remove a notification' do
      visit user_path(@user)
      fill_in 'my_products_notification[discount]', with: '15'
      click_on 'Save notification'
      click_on 'Remove'

      expect(find_field('my_products_notification[discount]').value).to eq('')
    end
  end

  scenario 'User is redirected back if he doesn\'t exist' do
    ObjectCreation.create_product
    ObjectCreation.create_price_log

    visit category_index_path
    click_on 'Track-it'

    expect(page).to have_content 'You must log in to track products'
  end

  scenario 'User is redirected to user show page after tracking a product' do
    FeatureSupport.create_and_login_user
    ObjectCreation.create_product
    ObjectCreation.create_price_log

    visit category_index_path
    click_on 'Track-it'

    expect(page).to have_content "Target discount:"
  end
end
