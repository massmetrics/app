class MyProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_uniqueness_of :product, scope: :user, message: 'is already tracked'

end