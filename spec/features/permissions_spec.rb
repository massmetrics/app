require 'rails_helper'

feature 'Permissions and authorization' do
  before do
    Submission.create!(sku: '12345', category: 'Some category')
  end
  context 'guest' do
    scenario 'viewing the suggested products' do
      visit '/'
      expect(page).to_not have_link('Admin')
      visit admin_submissions_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end

  context 'user' do
    before do
      user = ObjectCreation.create_user
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    scenario 'viewing suggested products' do
      expect(page).to_not have_link('Admin')
      visit admin_submissions_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end

  context 'admin' do
    before do
      user = ObjectCreation.create_user(role: 'admin')
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    scenario 'viewing suggested products' do
      expect(page).to_not have_link('Admin')
      visit admin_submissions_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end
end