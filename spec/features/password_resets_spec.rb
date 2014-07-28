require 'rails_helper'

feature 'forgot password' do
  scenario 'it allows the user to reset password' do
    user = ObjectCreation.create_user(reset_password_token: '10')

    visit new_user_session_path
    click_on 'Forgot Password?'
    fill_in 'Email', with: user.email
    click_on 'Reset Password'

    expect(page).to have_content 'Instructions have been sent to your email.'

    visit edit_password_reset_path(user.reset_password_token)

    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_on 'Reset Password'

    expect(page).to have_content 'Password was successfully updated.'
  end
end