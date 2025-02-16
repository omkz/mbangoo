class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  include PgSearch::Model
  pg_search_scope :search_by_name_and_description,
                  against: [:name, :description],
                  using: {
                    tsearch: { prefix: true },
                    trigram: { threshold: 0.1 }
                  }

  scope :filter_by_category, ->(category_id) {
    category = Category.find(category_id)
    where(
      id: joins(:categories)
        .where(categories: { id: category.self_and_descendants_ids })
        .select('DISTINCT products.id')
    )
  }

  scope :filter_by_price_range, ->(min_price, max_price) {
    scope = joins(:master_variant)
    if min_price.present? && max_price.present?
      scope.where(product_variants: { price: min_price..max_price })
    elsif min_price.present?
      scope.where('product_variants.price >= ?', min_price)
    elsif max_price.present?
      scope.where('product_variants.price <= ?', max_price)
    else
      scope
    end
  }

  scope :sorted_by, ->(sort_option) {
    case sort_option
    when "price_asc"
      joins(:master_variant).order('product_variants.price ASC')
    when "price_desc"
      joins(:master_variant).order('product_variants.price DESC')
    when "newest"
      order(created_at: :desc)
    else
      order(created_at: :desc)
    end
  }

  has_many_attached :images

  has_many :product_categories
  has_many :categories, through: :product_categories

  has_many :variants, class_name: "ProductVariant", dependent: :destroy

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
  validate :at_least_one_category

  def self.price_range
    master_variants = ProductVariant.where(is_master: true)
    {
      min: master_variants.minimum(:price) || 0,
      max: master_variants.maximum(:price) || 0
    }
  end

  def self.search(query = nil, category = nil, min_price = nil, max_price = nil, sort = nil)
    result = joins(:master_variant)
    result = result.where(id: search_by_name_and_description(query).select(:id)) if query.present?
    result = result.filter_by_category(category) if category.present?
    result = result.filter_by_price_range(min_price, max_price) if min_price.present? || max_price.present?
    result = result.sorted_by(sort) if sort.present?
    result
  end

  def has_variants?
    variants.any?
  end

  def is_master?
    master_variant.present?
  end

  def available_option_types
    option_types
  end

  def master_variant_price
    master_variant&.price || 0
  end

  private

  def only_one_master_variant
    master_variants_count = variants.select(&:is_master).count
    if master_variants_count > 1
      errors.add(:base, "Only one master variant is allowed")
    end
  end

  def at_least_one_category
    errors.add(:base, "Must have at least one category") if categories.empty?
  end

end