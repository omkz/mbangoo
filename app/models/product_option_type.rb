class ProductOptionType < ApplicationRecord
  belongs_to :product
  belongs_to :option_type

  validates :product_id, uniqueness: { scope: :option_type_id }
end