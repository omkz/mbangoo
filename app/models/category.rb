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

  def self_and_descendants_ids
    query = <<-SQL
      WITH RECURSIVE category_tree AS (
        SELECT id FROM categories WHERE id = ?
        UNION ALL
        SELECT c.id FROM categories c
        INNER JOIN category_tree ct ON ct.id = c.parent_id
      )
      SELECT id FROM category_tree;
    SQL
  
    Category.find_by_sql([query, id]).pluck('id')
  end

  private

  def generate_slug
    self.slug = name.parameterize if slug.blank?
  end
end
