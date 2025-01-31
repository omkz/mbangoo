class OptionType < ApplicationRecord
  has_many :option_values, dependent: :destroy
  has_many :product_option_types, dependent: :destroy
  has_many :products, through: :product_option_types

  validates :name, presence: true, uniqueness: true
end