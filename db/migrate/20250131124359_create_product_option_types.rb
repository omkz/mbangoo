class CreateProductOptionTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :product_option_types do |t|
      t.references :product, null: false, foreign_key: true
      t.references :option_type, null: false, foreign_key: true
      t.timestamps
    end

    add_index :product_option_types, [:product_id, :option_type_id], unique: true
  end
end
