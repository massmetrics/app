class Category < ActiveRecord::Base
  belongs_to :product

  def self.category_list
    all.map do |category|
      category.category
    end.uniq!
  end
end