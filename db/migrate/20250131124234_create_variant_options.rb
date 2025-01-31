class CreateVariantOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :variant_options do |t|
      t.references :product_variant, null: false, foreign_key: true
      t.references :option_value, null: false, foreign_key: true

      t.timestamps
    end
  end
end
