module Orderable
  extend ActiveSupport::Concern

  included do
    helper_method :current_order
  end

  def current_order
    if current_user
      find_or_create_order_for_user
    else
      find_or_create_guest_order
    end
  end

  private

  def find_or_create_order_for_user
    if session[:order_id].present?
      find_existing_order_for_user
    else
      create_order_for_user
    end
  end

  def find_or_create_guest_order
    if session[:order_id].present?
      find_existing_guest_order
    else
      create_guest_order
    end
  end

  def create_order_for_user
    order = Order.create(user: current_user, order_status_id: 1)
    session[:order_id] = order.id
    order
  end

  def find_existing_order_for_user
    order = Order.find(session[:order_id])

    if order.user.nil?
      order.user = current_user
      order.save
    elsif order.user != current_user
      session[:order_id] = nil
      return create_order_for_user
    end

    order
  rescue ActiveRecord::RecordNotFound
    session[:order_id] = nil
    create_order_for_user
  end

  def create_guest_order
    order = Order.create(order_status_id: 1)
    session[:order_id] = order.id
    order
  end

  def find_existing_guest_order
    Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    session[:order_id] = nil
    create_guest_order
  end
end
