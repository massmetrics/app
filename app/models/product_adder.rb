class ProductAdder
  def self.add(sku_array, category_array)
    sku_array.each do |sku|
      product = Product.find_by_sku(sku) || Product.create_from_sku(sku)
      if product
        product.add_categories(category_array)
      end
    end
  end
end