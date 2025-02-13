module Admin
  class OrdersController < BaseController
    layout 'admin'
    
    def index
      @orders = Order.includes(:user)
                     .order(created_at: :desc)
                     .page(params[:page]).per(15)
    end

    def show
      @order = Order.find(params[:id])
    end
    
    private

    def order_params
      params.require(:order).permit(:status, :shipping_method, :payment_status)
    end
  end
end