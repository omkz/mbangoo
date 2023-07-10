class ApplicationController < ActionController::Base
  helper_method :current_order

  def current_order
    if session[:order_id].nil?
      Order.new
    else
      begin
        Order.find(session[:order_id])
      rescue ActiveRecord::RecordNotFound => e
        Order.new
      end
    end
  end
end
