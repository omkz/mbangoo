class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description
      t.string :slug, null: false, index: { unique: true }
      t.integer :position, default: 0
      t.boolean :active, default: true
      t.references :parent, foreign_key: { to_table: :categories }, index: true, null: true

      t.timestamps
    end

    add_index :categories, :name
    add_index :categories, :active
  end
end
