class ApplicationController < ActionController::Base
  helper_method :current_order

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
end
