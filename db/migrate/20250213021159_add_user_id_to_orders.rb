class AddUserIdToOrders < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :user, null: true, foreign_key: true
  end
end
