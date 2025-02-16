class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_status
  has_many :order_items, dependent: :destroy

  def status
    order_status.name
  end

  def subtotal
    order_items.sum(:total_price)
  end

  def total
    subtotal + (tax || 0) + (shipping || 0)
  end

  def update_subtotal_and_total
    update!(subtotal: subtotal, total: total)
  end
end