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
  end
end