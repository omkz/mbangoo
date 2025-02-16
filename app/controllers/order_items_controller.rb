class OrderItemsController < ApplicationController
  before_action :set_order

  def create
    existing_item = @order.order_items.find_by(product_variant_id: order_item_params[:product_variant_id])
  
    if existing_item
      existing_item.increment!(:quantity, order_item_params[:quantity].to_i)
      if existing_item.save
        flash[:notice] = "Quantity updated in cart"
      else
        flash[:error] = "Failed to update quantity"
      end
    else
      @order_item = @order.order_items.build(order_item_params)
      if @order_item.save
        flash[:notice] = "Product added to cart"
      else
        flash[:error] = "Failed to add product"
      end
    end
  
    redirect_to cart_path
  end
  

  def update
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      flash[:notice] = "Cart updated"
      redirect_to cart_path
    else
      flash[:error] = "Failed to update cart"
      render :edit
    end
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])
    @order_item.destroy

    flash[:notice] = "#{@order_item.product.name} removed from the cart"
    redirect_to cart_path
  end

  private

  def set_order
    @order = CurrentOrderService.new(current_user, session).create_order_if_needed
  end

  def order_item_params
    params.require(:order_item).permit(:product_variant_id, :quantity)
  end
end
