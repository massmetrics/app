require 'rails_helper'

feature 'Sessions' do
  scenario 'User can login' do
    user = ObjectCreation.create_user
    visit '/'
    click_link 'Login'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    save_and_open_page
    click_button 'Login'


    expect(page).to have_content("Welcome #{user.email}")
  end
end