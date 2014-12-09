require "rails_helper"

describe ProductCategory do
  context 'validations' do
    it 'does not allow duplicate product categories' do
      product = ObjectCreation.create_product
      category = ObjectCreation.create_category

      valid_product_category = ProductCategory.create(product_id: product.id,
                                                      category_id: category.id)
      invalid_product_category = ProductCategory.create(product_id: product.id,
                                                        category_id: category.id)
      expect(valid_product_category.valid?).to eq(true)
      expect(invalid_product_category.valid?).to eq(false)
    end
  end
end