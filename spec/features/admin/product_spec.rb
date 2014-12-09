require 'rails_helper'

feature 'Products' do
  before do
    @p1 = ObjectCreation.create_product(sku: '2345', title: 'p1')
    @category1 = Category.create(product: @p1, category: 'protein')
    @p2 = ObjectCreation.create_product(sku: '23456', title: 'p2')
    @p3 = ObjectCreation.create_product(sku: '234567', title: 'p3')
    @p4 = ObjectCreation.create_product(sku: '2345678', title: 'p4')
    FeatureSupport.create_and_login_admin
  end
  context 'viewing products' do
    scenario 'admin views a list of all products in database' do
      click_link 'Products'
      expect(page).to have_content(@p1.title)
      expect(page).to have_content(@p2.title)
      expect(page).to have_content(@p3.title)
      expect(page).to have_content(@p4.title)
      within("##{@p1.sku}") do
        click_on 'Edit'
      end
      expect(find_field('categories').value).to eq(@category1.category)
    end
  end
  context 'managing product categories' do
    scenario 'admin adds a category to a product' do
      click_link 'Products'
      within("##{@p1.sku}") do
        click_on 'Edit'
      end
      fill_in 'categories', with: 'protein, something else'
      click_on 'Update'
      @p1.reload
      categories = @p1.categories.map { |c| c.category }.sort.join(',')
      expect(categories).to eq('Protein,Something Else')
      expect(find_field('categories').value).to eq(categories)
    end
    scenario 'admin deletes a category from a product' do
      click_link 'Products'
      within("##{@p1.sku}") do
        click_on 'Edit'
      end
      fill_in 'categories', with: 'something else'
      click_on 'Update'
      @p1.reload
      categories = @p1.categories.map { |c| c.category }.join(',')
      expect(categories).to eq('Something Else')
    end

    scenario 'admin can delete a product' do
      click_link 'Products'
      within("##{@p1.sku}") do
        click_on 'Delete'
      end
      expect(page).to have_no_content(@p1.title)
    end
  end

  context 'managing products' do
    scenario 'admin adds a product' do
      new_time = '2014-12-09T08:21:25Z'
      Timecop.freeze(new_time) do
        VCR.use_cassette('admin/new_products') do
          click_link 'Products'
          click_link 'Add New Product'
          fill_in 'sku', with: 'B0057RKQ4Q'
          fill_in 'category', with: 'Creatine'
          click_on 'Add Product'

          expect(page).to have_content 'Product successfully added'
        end
      end
    end

    scenario 'doesnt enter either an sku or categories' do
      click_link 'Products'
      click_link 'Add New Product'
      fill_in 'sku', with: ''
      fill_in 'category', with: 'awd'
      click_on 'Add Product'
      expect(page).to have_content('Please set params')
      fill_in 'sku', with: 'awd'
      fill_in 'category', with: ''
      click_on 'Add Product'
      expect(page).to have_content('Please set params')
      fill_in 'sku', with: ''
      fill_in 'category', with: ''
      click_on 'Add Product'
      expect(page).to have_content('Please set params')
    end
  end
end