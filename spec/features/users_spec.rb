require 'rails_helper'

feature 'Sessions' do
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