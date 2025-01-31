class Product < ApplicationRecord
  has_many :variants, class_name: "ProductVariant", dependent: :destroy
  has_many_attached :images
  has_many :order_items

  enum :status, { active: 0, inactive: 1 }, validate: true
  validates :name, presence: true
  validates :description, presence: true
end
