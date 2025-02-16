class CurrentOrderService
  def initialize(user, session)
    @user = user
    @session = session
  end

  def current_order
    return find_existing_order if @session[:order_id].present?
    return find_unfinished_order_for_user if @user

    nil
  end

  def create_order_if_needed
    return current_order if current_order.present?

    order = @user ? create_order_for_user : create_guest_order
    @session[:order_id] = order.id
    order
  end

  private

  def find_existing_order
    Order.find(@session[:order_id])
  rescue ActiveRecord::RecordNotFound
    @session[:order_id] = nil
    nil
  end

  def find_unfinished_order_for_user
    @user.orders.where(order_status_id: 1).last
  end

  def create_order_for_user
    Order.create(user: @user, order_status_id: 1)
  end

  def create_guest_order
    Order.create(order_status_id: 1)
  end
end
