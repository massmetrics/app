class ProductAdder
  class << self
    def add(sku_array, category_array)
      sku_array.each do |sku|
        product = Product.find_by_sku(sku) || Product.create_from_sku(sku)
        if product
          product.add_categories(category_array)
        end
        sleep 10
      end
    end
  end
end