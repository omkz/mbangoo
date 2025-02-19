# app/controllers/admin/images_controller.rb
module Admin
  class ImagesController < BaseController
    layout 'admin'
    before_action :set_product

    def index
      @images = @product.images
    end

    def create
      if params[:images].present?
        params[:images].each do |image|
          @product.images.attach(image)
        end
        redirect_to admin_product_images_path(@product), notice: 'Images uploaded successfully.'
      else
        redirect_to admin_product_images_path(@product), alert: 'Please select images to upload.'
      end
    end

    def destroy
      image = @product.images.find(params[:id])
      image.purge
      redirect_to admin_product_images_path(@product), notice: 'Image removed successfully.'
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_product_images_path(@product), alert: 'Image not found.'
    end

    private

    def set_product
      @product = Product.friendly.find(params[:product_id])
    end
  end
end
