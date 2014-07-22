class ProductSorter
  class << self
    def sort_by_percentage(products_array, items = 10)
      products_array.sort_by { |product| product[1] }.reverse[0...items].map { |product| product[0] }
    end
  end
end