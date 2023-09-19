class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def index
    session[:order_id] = nil
   end

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

  def webhook
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      render plain: "Webhook error while parsing basic request. #{e.message}", status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      render plain: "Webhook signature verification failed. #{e.message}", status: 400
      return
    end

    # Handle the event
    payment_intent = event.data.object
    case event.type
    when 'payment_intent.processing'
      handle_payment_intent_status(payment_intent, 2)
    when 'payment_intent.payment_failed'
      handle_payment_intent_status(payment_intent, 3)
    when 'payment_intent.succeeded'
      handle_payment_intent_status(payment_intent, 4)
    else
      puts "Unhandled event type: #{event.type}"
    end

    render plain: "Status updated", status: 200
  end

  private

   def endpoint_secret
     Rails.application.credentials.dig(:stripe, :signing_secret)
   end

   def handle_payment_intent_status(payment_intent, status)
    Order.find_by(id: payment_intent.metadata.order_id).update(order_status_id: status)
  end

end
