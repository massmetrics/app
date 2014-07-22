class ProductAdder
  def self.add(sku_array, category_array)
    sku_array.each do |sku|
      product = Product.create_from_sku(sku)
      product.add_categories(category_array)
    end
  end
end