module Admin
  class ProductsController < BaseController
    layout "admin"
    before_action :set_product, only: %i[ show edit update ]
    def index
      @products = Product.all
    end

    def new
      @product = Product.new
      @product.variants.build
    end

    def show
    end

    def edit
    end

    def create
      @product = Product.new(product_params)

      respond_to do |format|
        if @product.save
          format.html { redirect_to edit_admin_product_path(@product), notice: "Product was successfully created." }
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
          format.html { redirect_to edit_admin_product_path(@product), notice: "Product was successfully updated." }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end


    private

    def set_product
      @product = Product.friendly.find(params[:id])
    end

    def product_params
      params.require(:product).permit(
        :name,
        :description,
        :status,
        variants_attributes: [
          :id,
          :sku,
          :price,
          :stock,
          :is_master,
          :_destroy
        ],
        images:[],
        option_type_ids: [],
        category_ids: []
      )
    end
  end
end
