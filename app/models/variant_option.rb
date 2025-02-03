class VariantOption < ApplicationRecord
  belongs_to :product_variant
  belongs_to :option_value

  attr_accessor :option_type_id
end