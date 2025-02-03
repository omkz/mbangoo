module Admin
  class VariantsController < BaseController
    layout "admin"
  
    before_action :set_product, only: %i[ index new create]
    def index
      @variants = @product.variants
    end
  
    def new
      @variant = @product.variants.build
      @product.available_option_types.each do |option_type|
        @variant.variant_options.build
      end
    end
  
    def create
      @variant = @product.variants.build(variant_params)
  
      if @variant.save
        redirect_to admin_product_variants_path(@product), notice: 'Variant was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_product
      @product = Product.find(params[:product_id])
    end
   
    def variant_params
      params.require(:product_variant).permit(
        :sku, :price, :stock, 
        variant_options_attributes: [
          :id, 
          :option_type_id, 
          :option_value_id, 
          :_destroy
        ]
      )
    end
  
  end

end