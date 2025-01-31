class Product < ApplicationRecord
  has_many :variants, class_name: "ProductVariant", dependent: :destroy
  has_many_attached :images
  has_many :order_items

end
