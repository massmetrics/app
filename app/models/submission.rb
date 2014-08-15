class Submission < ActiveRecord::Base
  validates :category, presence: true
  validates :sku, presence: true
  validates :sku, length: { is: 10, message: "Invalid SKU" }
  has_many :categories
end