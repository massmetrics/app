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
  end
end