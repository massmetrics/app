require 'rails_helper'

feature 'forgot password' do
  before do
    @user = ObjectCreation.create_user(reset_password_token: '10')

    visit new_user_session_path
    click_on 'Forgot Password?'
    fill_in 'Email', with: @user.email
    click_on 'Reset Password'

    @user.reload
  end
  scenario 'it allows the user to reset password' do


    visit edit_password_reset_path(@user.reset_password_token)

    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_on 'Reset Password'

    expect(page).to have_content 'Password was successfully updated.'

    click_on 'Login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'new_password'
    click_button 'Login'
    expect(page).to have_content(@user.email)
  end

  scenario 'user is redirected to edit page if password and confirmation differ' do
    visit edit_password_reset_path(@user.reset_password_token)

    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_on 'Reset Password'

    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

  scenario 'user is redirected to root if blank' do
    visit edit_password_reset_path(@user.reset_password_token)
    User.destroy(@user.id)
    fill_in 'user[password]', with: 'new_password'
    fill_in 'user[password_confirmation]', with: 'new_password'
    click_on 'Reset Password'

    expect(page).to have_content 'Best deals'
  end

  scenario 'user cannot visit edit password page if blank' do
    User.destroy(@user.id)
    visit edit_password_reset_path(@user.reset_password_token)

    expect(page).to have_content 'Topics'
  end
end