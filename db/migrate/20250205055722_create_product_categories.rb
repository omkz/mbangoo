class CreateProductCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :product_categories do |t|
      t.references :product, foreign_key: true, null: false
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end

    add_index :product_categories, [:product_id, :category_id], unique: true
  end
end
