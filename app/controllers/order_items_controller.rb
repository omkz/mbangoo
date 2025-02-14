class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      @order.save  # Explicitly save to trigger total calculation
      flash.now[:notice] = "Product added to cart"
      redirect_to cart_path
    else
      flash.now[:error] = "Failed to add product"
      render :new
    end
  end

  def update
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      @order.save
      flash.now[:notice] = "Cart updated"
      redirect_to cart_path
    else
      flash.now[:error] = "Failed to update cart"
      render :edit
    end
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy

    @order.save
    flash.now[:notice] = "#{@order_item.product.name} removed from the cart"
    redirect_to cart_path
  end

  private

  def set_order
    @order = current_order
  end

  def order_item_params
    params.require(:order_item).permit(
      :product_variant_id,
      :quantity
    )
  end
end