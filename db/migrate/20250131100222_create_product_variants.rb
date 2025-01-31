class CreateProductVariants < ActiveRecord::Migration[7.2]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :sku, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, default: 0
      t.boolean :is_master, default: false, null: false

      t.timestamps
    end

    add_index :product_variants, :sku, unique: true
  end
end
