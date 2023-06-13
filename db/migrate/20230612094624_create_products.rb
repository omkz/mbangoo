class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :active
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
