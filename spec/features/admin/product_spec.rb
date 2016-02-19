require 'rails_helper'

feature 'Products' do
  before do
    @p1 = ObjectCreation.create_product(sku: '2345', title: 'p1')
    @category1 = Category.create(name: 'protein')
    @category2 = Category.create(name: 'something else')
    @p2 = ObjectCreation.create_product(sku: '23456', title: 'p2')
    @p3 = ObjectCreation.create_product(sku: '234567', title: 'p3')
    @p4 = ObjectCreation.create_product(sku: '2345678', title: 'p4')
    FeatureSupport.create_and_login_admin
  end
  context 'viewing products' do

    scenario 'admin views a list of all products in database' do
      ProductCategory.create(product_id: @p1.id, category_id: @category1.id)
      click_link 'Products'
      expect(page).to have_content(@p1.title)
      expect(page).to have_content(@p2.title)
      expect(page).to have_content(@p3.title)
      expect(page).to have_content(@p4.title)
      within("##{@p1.sku}") do
        click_on 'Edit'
      end
      expect(find_field('category').value).to eq(@category1.id.to_s)
    end
  end
  context 'managing product categories' do

    scenario 'admin adds a category to a product' do
      click_link 'Products'
      within("##{@p1.sku}") do
        click_on 'Edit'
      end
      select "Protein", :from => "category"
      click_on 'Update'
      @p1.reload
      expect(@p1.categories).to include(@category1)
      expect(find_field('category').value).to eq(@category1.id.to_s)
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
      new_time = '2016-02-19T14:30:30.517389'
      Timecop.freeze(new_time) do
        VCR.use_cassette('admin/new_products') do
          click_link 'Products'
          click_link 'Add New Product'
          fill_in 'sku', with: 'B0057RKQ4Q'
          fill_in 'category', with: 'Protein'
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