class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :tax, precision: 8, scale: 2
      t.decimal :shipping, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.references :order_status, foreign_key: true

      t.timestamps
    end
  end
end
