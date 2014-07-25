require 'rails_helper'

feature 'User' do
  context 'Registering' do
    scenario 'A user can Register' do
      visit '/'
      click_link 'Register'
      fill_in 'Email', with: 'Joe@example.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Register'

      expect(page).to have_content 'Joe@example.com'
      expect(page).to have_link('Logout')
      expect(page).to_not have_link('Register')
      expect(page).to_not have_link('Login')
    end

    scenario 'A user is redirected to register page if registration fails' do
      visit '/'
      click_link 'Register'
      fill_in 'Email', with: 'n'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Register'

      expect(page).to have_link('Register')
      expect(page).to have_link('Login')
    end
  end

  context 'Managing items' do
    scenario 'a user can track products' do
      user = FeatureSupport.create_and_login_user
      product = ObjectCreation.create_product

      visit product_path(product)
      click_on 'Track Product'
      visit user_path(user)

      expect(page).to have_content product.title
    end

    scenario 'a user cannot track a product twice' do
      FeatureSupport.create_and_login_user
      product = ObjectCreation.create_product
      visit product_path(product)
      click_on 'Track Product'
      click_on 'Track Product'
      expect(page).to have_content("Product is already tracked")
    end
  end
end