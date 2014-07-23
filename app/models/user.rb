class User < ActiveRecord::Base
  as_enum :role, admin: 1, user: 0
  before_create :set_role
  authenticates_with_sorcery!

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def role?(role)
    self.role == role
  end

  private
  def set_role
    self.role = :user unless self.role
  end
end
