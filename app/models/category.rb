class Category < ActiveRecord::Base
  belongs_to :product

  def self.category_list
    categories = all.map do |category|
      category.category
    end.uniq
    categories.map do |category|
      if Product.category_discounts(category).length > 0
        category
      end
    end
  end

end