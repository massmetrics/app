require 'rails_helper'

feature 'Submissions' do
  before do
    Submission.create(sku: '12345', category: 'category')
  end
  context 'viewing submissions' do
    scenario 'Admin can view submissions' do
      FeatureSupport.create_and_login_admin
      click_link 'Submissions'

      expect(page).to have_content "SKU: 12345"
      expect(page).to have_content "Category: category"
    end
  end
end