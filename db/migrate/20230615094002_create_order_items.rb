class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.decimal :unit_price, precision: 8, scale: 2
      t.integer :quantity
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
