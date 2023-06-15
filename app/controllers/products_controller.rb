class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  def show
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product_params).permit(:name, :description, :price, :active)
  end
end
