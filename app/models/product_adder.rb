class ProductAdder
  def self.add(sku, category)
    product = Product.create_from_sku(sku)
    product.add_categories(category)
    product
  end
end