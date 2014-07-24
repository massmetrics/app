class Category < ActiveRecord::Base
  belongs_to :product
  before_create :capitalize_category

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

  private
  def capitalize_category
    self.category = self.category.split(' ').map(&:capitalize).join(' ')
  end
end