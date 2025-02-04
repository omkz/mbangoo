class RemoveProductIdFromOrderItems < ActiveRecord::Migration[7.2]
  def change
    remove_reference :order_items, :product, foreign_key: true
  end
end
