class Category < ActiveRecord::Base

  has_many :product_categories
  has_many :products, through: :product_categories
  before_create :capitalize_category

  validates :name, uniqueness: true

  def self.category_list
    all_categories.map do |category|
      if Product.category_discounts(category).length > 0
        category
      end
    end.compact
  end

  def self.all_categories
    all.map do |category|
      category.name
    end.uniq
  end

  private
  def capitalize_category
    self.name = self.name.split(' ').map(&:capitalize).join(' ')
  end
end