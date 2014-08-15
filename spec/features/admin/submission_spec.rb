require 'rails_helper'

feature 'Submissions' do
  before do
    @submission = Submission.create(sku: 'B003CTE1LU', category: 'category')
    FeatureSupport.create_and_login_admin
  end
  context 'viewing submissions' do
    scenario 'Admin can view submissions' do
      click_link 'Submissions'

      expect(page).to have_content "SKU: #{@submission.sku}"
      expect(page).to have_content "Category: #{@submission.category}"
    end
  end

  context 'managing submissions' do
    scenario 'Admin adds submission to database' do
      new_time = "2014-07-24T00:03:23Z"
      Timecop.freeze(new_time) do
        VCR.use_cassette('features/admin/submission/add_submission') do
          click_link 'Submissions'
          click_link 'Add'

          expect(find_field('submission[sku]').value).to eq(@submission.sku)
          expect(find_field('submission[category]').value).to eq(@submission.category)
          expect(page.has_xpath?("//a[@href='http://www.amazon.com/gp/product/#{@submission.sku}/']")).to eq(true)
          click_button 'Add'

          product = Product.find_by_sku("B003CTE1LU")
          expect(product.categories.map { |category| category.category }).to include(@submission.category.capitalize)

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