class Product < ApplicationRecord
  has_many_attached :images

  has_many :variants,
  -> { where(is_master: false)},
  inverse_of: :product,
  class_name: 'ProductVariant',
  dependent: :destroy

  accepts_nested_attributes_for :variants,
    allow_destroy: true,
    reject_if: :all_blank

  has_many :variants_including_master,
    -> { order(:sku) },
    inverse_of: :product,
    class_name: 'ProductVariant',
    dependent: :destroy

  has_one :master_variant,
    -> { where(is_master: true) },
    class_name: "ProductVariant",
    dependent: :destroy

  has_many :variant_options, through: :variants
  has_many :product_option_types
  has_many :option_types, through: :product_option_types

  accepts_nested_attributes_for :product_option_types,
    allow_destroy: true,
    reject_if: :all_blank

  accepts_nested_attributes_for :option_types,
    allow_destroy: true,
    reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true
  enum :status, { active: 0, inactive: 1 }, validate: true

  validate :only_one_master_variant
  
  def has_variants?
    variants.any?
  end

  def is_master?
    master_variant.present?
  end

  def available_option_types
    option_types
  end


  private

  def only_one_master_variant
    master_variants_count = variants.select(&:is_master).count
    if master_variants_count > 1
      errors.add(:base, "Only one master variant is allowed")
    end
  end

end
