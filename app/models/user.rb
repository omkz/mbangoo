class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :orders, dependent: :destroy

  after_create :assign_default_role

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end

  private

  def assign_default_role
    roles << Role.find_or_create_by(name: "user") if roles.empty?
  end  
end