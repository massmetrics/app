require 'rails_helper'

feature 'Submissions' do
  before do
    category = ObjectCreation.create_category
    @submission = Submission.create(sku: 'B003CTE1LU', category: category.name )
    FeatureSupport.create_and_login_admin
  end
  context 'viewing submissions' do
    scenario 'Admin can view submissions' do
      click_link 'Submissions'

      expect(page).to have_content "SKU: #{@submission.sku}"
      expect(page).to have_content "Category: #{@submission.category}"
    end
  end

  context 'notification' do
    scenario 'admin sees a notification with the number of active submissions in parentheses' do
      expect(page).to have_link('Admin (1)')
    end
  end

  context 'managing submissions' do
    scenario 'Admin adds submission to database' do
      VCR.use_cassette('features/admin/submission/add_submission') do |cassette|
        new_time = cassette.originally_recorded_at || Time.now
        Timecop.freeze(new_time) do
          click_link 'Submissions'
          click_link 'Add'

          expect(find_field('submission[sku]').value).to eq(@submission.sku)
          expect(find_field('submission[category]').value).to eq(@submission.category)
          expect(page.has_xpath?("//a[@href='http://www.amazon.com/gp/product/#{@submission.sku}/']")).to eq(true)
          click_button 'Add'
          product = Product.find_by_sku(@submission.sku)
          expect(product.categories.map { |category| category.name }).to include(@submission.category.capitalize)

          visit admin_submissions_path

          expect(page).to have_no_content "B003CTE1LU"
        end
      end
    end

    scenario 'Admin can reject submissions' do
      click_link 'Submissions'
      click_link 'Reject'

      expect(page).to have_no_content "SKU: #{@submission.sku}"
      expect(page).to have_no_content "Category: #{@submission.category}"
    end
  end
end
