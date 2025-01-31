class RemovePriceAndActiveFromProducts < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :price, :decimal
    remove_column :products, :active, :boolean
    add_column :products, :status, :integer, default: 0
  end
end
