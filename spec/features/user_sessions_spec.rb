require 'rails_helper'

feature 'Sessions' do
  before do
    @user = ObjectCreation.create_user

  end
  scenario 'User can login and logout' do

    visit '/'
    click_link 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content("#{@user.email}")
    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Register')
    expect(page).to_not have_link('Login')

    click_link 'Logout'

    expect(page).to have_link('Login')
    expect(page).to have_link('Register')
    expect(page).to_not have_content('Logout')
    expect(page).to_not have_content("#{@user.email}")
  end

  scenario 'User is given an error if login fails' do
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: 'incorrectemail@noplace.com'
    fill_in 'Password', with: 'password'
    click_button 'Login'

    expect(page).to have_content('Login failed')
  end
end