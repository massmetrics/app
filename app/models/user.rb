class User < ActiveRecord::Base
  as_enum :role, admin: 1, user: 0
  before_create :set_role
  has_many :my_products
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates :email, :presence => true
  validates :email, :email => true
  validates_uniqueness_of :email

  def role?(role)
    self.role == role
  end

  def tracked?(product)
    truthy = false
    my_products.each do |my_product|
      if my_product.product == product
        truthy = true
      end
    end
    truthy
  end

  private
  def set_role
    self.role = :user unless self.role
  end
end
