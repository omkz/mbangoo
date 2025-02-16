class CartsController < ApplicationController
  
  def show
    @order = current_order || Order.new
    @order_items = @order.order_items
  end
end
