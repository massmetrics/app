require 'rails_helper'

feature 'Permissions and authorization' do
  context 'guest' do
    scenario 'tries to access the admin section' do
      visit '/'
      
      expect(page).to_not have_link('Admin')

      visit admin_base_index_path

      expect(page).to have_content('You don\'t have permission to access that page')
    end

    scenario 'tries to track an item' do
      product = ObjectCreation.create_product
      visit product_path(product)
      click_on 'Track-it'
      expect(page).to have_content('You must log in to track products')
    end

    scenario 'tries to visit a users profile' do
      user = ObjectCreation.create_user
      visit user_path(user)

      expect(page).to have_content('You don\'t have permission to access that page')
    end
  end

  context 'user' do
    before do
      @user = ObjectCreation.create_user
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    scenario 'tries to access the admin section' do

      expect(page).to_not have_link('Admin')

      visit admin_base_index_path

      expect(page).to have_content('You don\'t have permission to access that page')
    end

    scenario 'A user can visit their personal page' do
      visit user_path(@user)

      expect(page).to have_content('My Products')
    end

    scenario 'a user cannot visit another user page' do
      user = ObjectCreation.create_user(email:'uniqueemail@aol.com')
      visit user_path(user)

      expect(page).to have_content('You don\'t have permission to access that page')
    end
  end

  context 'admin' do
    scenario 'accesses the admin section' do
      FeatureSupport.create_and_login_admin

      expect(page).to have_content('Admin Section')
    end

    scenario 'accesses a user page' do
      user = ObjectCreation.create_user
      FeatureSupport.create_and_login_admin

      visit user_path(user)

      expect(page).to have_content('My Products')
    end
  end
end