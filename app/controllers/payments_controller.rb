class PaymentsController < ApplicationController
  def charges
    @amount = current_order.subtotal
      payment_intent = Stripe::PaymentIntent.create(
      amount:  (@amount * 100).to_i,
      currency: 'usd',
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {order_id: "#{current_order.id}"},
      )

    @payment_intent_client_secret = payment_intent.client_secret;

  rescue Stripe::StripeError => e
    flash[:notice] = e.message
    redirect_to root_path

  rescue => e
    flash[:notice] = e.message
    redirect_to root_path
  end

  def index
   session[:order_id] = nil
  end

end
