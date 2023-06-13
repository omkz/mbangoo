class ProductsController < ApplicationController
  # def create

  #   @product = Post.new(product_params) do |product|
  #     product.user = current_user
  #   end

  #   respond_to do |format|
  #     if @product.save
  #       format.html { redirect_to @product, notice: 'Post was successfully created.' }
  #       format.json { render :show, status: :created, location: @product }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end


  # end

  # private

  # def set_product
  #   @product = Post.friendly.find(params[:id])
  #   authorize @product
  # end

  # def product_params
  #   params.require(:product_params).permit(:name, :description, :price, :user_id)
  # end
end
