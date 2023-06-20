class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :active, default: true
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
