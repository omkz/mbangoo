class OptionValue < ApplicationRecord
  belongs_to :option_type
  has_many :variant_options, dependent: :destroy
  has_many :product_variants, through: :variant_options

  validates :value, presence: true, uniqueness: true
end