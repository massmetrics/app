class MyProductsNotification < ActiveRecord::Base
  belongs_to :my_product
  before_create :string_to_float
  validates :discount, numericality: { greater_than: 0, less_than_or_equal_to: 100, message: 'is invalid.' }


  private
  def string_to_float
    self.discount = '%.2f' % (self.discount || 0)
  end
end