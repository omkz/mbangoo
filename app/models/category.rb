# app/models/category.rb
class Category < ApplicationRecord
  belongs_to :parent, class_name: 'Category', optional: true
  has_many :subcategories, class_name: 'Category', foreign_key: :parent_id, dependent: :destroy

  has_many :product_categories
  has_many :products, through: :product_categories

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :slug, presence: true, uniqueness: true

  scope :active, -> { where(active: true) }
  scope :root_categories, -> { where(parent_id: nil) }

  before_validation :generate_slug, on: :create

  def self.roots
    where(parent_id: nil)
  end

  def root?
    parent_id.nil?
  end

  def children
    Category.where(parent_id: id)
  end

  private

  def generate_slug
    self.slug = name.parameterize if slug.blank?
  end
end
