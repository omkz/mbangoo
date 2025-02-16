class OrderItem < ApplicationRecord
  belongs_to :product_variant
  belongs_to :order

  validates :quantity, 
    presence: true, 
    numericality: { 
      only_integer: true, 
      greater_than: 0 
    }

  before_save :set_prices
  after_commit :update_order_totals
  before_destroy :update_order_totals

  def product
    product_variant.product
  end

  def unit_price
    product_variant.price
  end

  def total_price
    unit_price * quantity
  end

  private

  def set_prices
    self.unit_price = unit_price
    self.total_price = total_price
  end

  def update_order_totals
    order.update_subtotal_and_total
  end
  
end