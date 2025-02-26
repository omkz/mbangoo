class ApplicationController < ActionController::Base
  helper_method :current_order
  before_action :load_categories

  unless Rails.env.production?
    before_action do
      Prosopite.scan
    end

    after_action do
      Prosopite.finish
    end
  end
  
  private

  def current_order
    @current_order ||= CurrentOrderService.new(current_user, session).current_order
  end

  def load_categories
    @categories = Category.includes(:subcategories).where(parent_id: nil)
  end

end
