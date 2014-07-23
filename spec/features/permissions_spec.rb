require 'rails_helper'

feature 'Permissions and authorization' do
  context 'guest' do
    scenario 'tries to access the admin section' do
      visit '/'
      expect(page).to_not have_link('Admin')
      visit admin_base_index_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end

  context 'user' do
    user = ObjectCreation.create_user
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    scenario 'tries to acess the admin section' do
      expect(page).to_not have_link('Admin')
      visit admin_base_index_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end

  context 'admin' do
    scenario 'accesses the admin section' do
      user = ObjectCreation.create_admin
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
      click_link 'Admin'
      expect(page).to have_content("Admin Section")
    end
  end
end