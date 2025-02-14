class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_status
  has_many :order_items, dependent: :destroy
 
  before_save :update_subtotal_and_total

  def status
    order_status.name
  end

  private

  def update_subtotal_and_total
    self.subtotal = order_items.sum(&:total_price)
    self.total = subtotal + (tax || 0) + (shipping || 0)
  end
end