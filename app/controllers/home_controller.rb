class HomeController < ApplicationController
  def index
    @products = Product.includes(images_attachments: :blob).limit(6)
  end
end
