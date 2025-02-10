class ProductsController < ApplicationController
  PRODUCTS_PER_PAGE = 24
  before_action :set_product, only: [:show]

  def index
    @products = fetch_products
    set_price_range
    set_categories_filter
  end

  def show
    @order_item = current_order.order_items.new
    @product = ProductDecorator.new(@product)
  end

  private

  def fetch_products
    Product.search(
      params[:search],
      params[:category_id],
      params[:min_price],
      params[:max_price],
      params[:sort]
    ).page(params[:page]).per(PRODUCTS_PER_PAGE)
  end

  def set_price_range
    price_range = Product.price_range
    @min_price = price_range[:min]
    @max_price = price_range[:max]
  end

  def set_categories_filter
    @categories_filter = Category.all
  end

  def set_product
    @product = Product.find(params[:id])
  end

end
