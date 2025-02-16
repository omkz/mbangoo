class ApplicationController < ActionController::Base
  helper_method :current_order

  private

  def current_order
    @current_order ||= CurrentOrderService.new(current_user, session).current_order
  end
end
