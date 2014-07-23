require 'rails_helper'

feature 'Permissions and authorization' do
  before do
    Submission.create!(sku: '12345', category: 'Some category')
  end
  context 'user' do
    scenario 'viewing the suggested products' do
      visit '/'
      expect(page).to_not have_link('Admin')
      visit admin_submissions_path
      expect(page).to have_content("You don't have permission to access that page")
    end
  end
end