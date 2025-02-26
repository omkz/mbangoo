class CartsController < ApplicationController
  def show
    @order = current_order || Order.new
    @order_items = @order.order_items.includes(product_variant: [ product: [images_attachments: :blob]])
  end

end