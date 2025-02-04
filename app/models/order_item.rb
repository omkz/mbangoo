class OrderItem < ApplicationRecord
  belongs_to :product_variant
  belongs_to :order

  validates :quantity, 
    presence: true, 
    numericality: { 
      only_integer: true, 
      greater_than: 0 
    }

  before_save :set_unit_price

  def product
    product_variant.product
  end

  def total_price
    unit_price * quantity
  end

  private

  def set_unit_price
    self.unit_price = product_variant.price
  end

  def product_present
    if product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end
  
end