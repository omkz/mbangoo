class Product < ApplicationRecord
  has_many_attached :images
  has_many :order_items

  default_scope { where(active: true) }

end
