class ProductAdder
  class << self
    def add_category(sku_array, category_array)
      sku_array.each do |sku|
        product = Product.find_by_sku(sku)
        if product
          product.add_categories(category_array)
        end
      end
    end

    def add(sku_array)
      Product.create_multiple(sku_array)
    end
  end
end