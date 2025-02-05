module Admin
  class CategoriesController < BaseController
    layout "admin"
    before_action :set_category, only: [:show, :edit, :update, :destroy]
  
    def index
      @categories = Category.all
    end
  
    def new
      @category = Category.new
      @parent_categories = Category.all
    end
  
    def create
      @category = Category.new(category_params)
  
      if @category.save
        redirect_to admin_categories_path, notice: 'Category was successfully created.'
      else
        @parent_categories = Category.all
        render :new
      end
    end
  
    def edit
      @parent_categories = Category.where.not(id: @category.id)
    end
  
    def update
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: 'Category was successfully updated.'
      else
        @parent_categories = Category.where.not(id: @category.id)
        render :edit
      end
    end
  
    def destroy
      @category.destroy
      redirect_to admin_categories_path, notice: 'Category was successfully deleted.'
    end
  
    private
  
    def set_category
      @category = Category.find(params[:id])
    end
  
    def category_params
      params.require(:category).permit(:name, :description, :parent_id)
    end
  end

end 
