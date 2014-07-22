class Category < ActiveRecord::Base
  belongs_to :product

  def self.category_list
    all_categories.map do |category|
      if Product.category_discounts(category).length > 0
        category
      end
    end.compact
  end

  def self.all_categories
    all.map do |category|
      category.category
    end.uniq
  end
end