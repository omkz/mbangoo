class ProductVariant < ApplicationRecord
  belongs_to :product

  has_many :variant_options, dependent: :destroy
  has_many :option_values, through: :variant_options
  has_many :order_items
   
  validates :sku, presence: true, uniqueness: { scope: :product_id }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  scope :in_stock, -> { where('stock > 0') }
end