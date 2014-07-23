require 'rails_helper'

feature 'Sessions' do
  scenario 'A user can login in' do
    visit '/'
    click_link 'Register'
    fill_in 'Email', with: 'Joe@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Register'
    expect(page).to have_content 'Welcome Joe@example.com'
  end
end