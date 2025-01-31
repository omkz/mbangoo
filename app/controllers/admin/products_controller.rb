module Admin
  class ProductsController < BaseController
    layout "admin"
    before_action :set_product, only: %i[ show edit update ]
    def index
      @products = Product.all
    end

    def new
      @product = Product.new
    end

    def show
    end

    def edit
    end

    def create
      @product = Product.new(product_params)
  
      respond_to do |format|
        if @product.save
          # flash.now[:notice] = "Added product to cart"
          format.html { redirect_to admin_product_path(@product), notice: "Product was successfully created." }
          format.json { render :show, status: :created, location: admin_product_path(@product) }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_product_path(@product), notice: "Product was successfully updated." }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  

    private
   
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :name, 
        :description, 
        :status)
    end
  end
end