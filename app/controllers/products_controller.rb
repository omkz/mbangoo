class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def show
    @order_item = current_order.order_items.new
    @product = ProductDecorator.new(@product)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product_params).permit(:name, :description, :price, :active)
  end
end
