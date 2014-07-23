require 'rails_helper'

feature 'Sessions' do
  scenario 'User can login' do
    user = ObjectCreation.create_user
    expect(user.valid?).to eq(true)
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'
    expect(page).to have_content("#{user.email}")
    expect(page).to have_link 'Logout'
    expect(page).to_not have_link('Register')
    expect(page).to_not have_link('Login')
  end
end