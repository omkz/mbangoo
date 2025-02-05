class OrderItemsController < ApplicationController

  def create
    @order = OrderItem.where(
      "product_variant_id = ? AND order_id = ?",
      params[:order_item][:product_variant_id],
      session[:order_id]
    ).first

    if @order
      @order.update(quantity: @order.quantity + params[:order_item][:quantity].to_i)
      @order.save
      flash.now[:notice] = "Add Product to the cart"
    else
      @order = current_order
      @order.order_status_id = 1 # Set status order, bukan order item
      @order_item = @order.order_items.new(order_item_params)

      if @order_item.save
        session[:order_id] = @order.id
        flash.now[:notice] = "Add Product to the cart"
      else
        flash.now[:error] = "Failed to Add product"
        render :new
      end
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy
    @order_items = @order.order_items
    flash.now[:notice] = "#{@order_item.product.name} removed from the cart."
  end

  private

  def order_item_params
    params.require(:order_item).permit(
      :product_variant_id,
      :quantity
    )
  end
end
