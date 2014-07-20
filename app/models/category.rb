class Category < ActiveRecord::Base
  belongs_to :product

  def self.category_list
    all.map do |category|
      if Product.category_discounts(category.category).length > 0
        category.category
      end
    end.uniq.reject {|c| c.nil?}
  end
end