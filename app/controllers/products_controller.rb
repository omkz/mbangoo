class ProductsController < ApplicationController
  PRODUCTS_PER_PAGE = 24
  before_action :set_product, only: [:show, :find_variant]

  def index
    @products = fetch_products
    set_price_range
    set_categories_filter
  end

  def show
    @order_item = OrderItem.new
  end
  
  def find_variant
    variant = @product.find_variant_by_option_values(params[:option_values])

    if variant
      render json: { variant_id: variant.id, price: variant.price }
    else
      render json: { error: "Variant not available" }, status: :not_found
    end
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
    @product = Product.friendly.find(params[:id])
  end

end
