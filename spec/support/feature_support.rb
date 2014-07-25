module FeatureSupport
  extend Capybara::DSL
  class << self
    def create_and_login_admin
      user = ObjectCreation.create_admin
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
      click_link 'Admin'
    end

    def create_and_login_user
      user = ObjectCreation.create_user
      visit '/'
      click_link 'Login'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'password'
      click_button 'Login'
      user
    end
  end
end