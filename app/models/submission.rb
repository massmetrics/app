class Submission < ActiveRecord::Base
  validates :category, presence: true
  validates :sku, presence: true
end