import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "paymentElement",
    "paymentErrors",
    "form",
    "linkAuthenticationElement",
  ];

  connect() {
    const clientSecret = this.element.getAttribute("data-secret-key");
    const stripe = Stripe(this.element.getAttribute("data-publishable-key"));
    const returnUrl = this.element.getAttribute("data-return-url");

    const appearance = {
      theme: "stripe",
    };

    const elements = stripe.elements({ appearance, clientSecret });

    const linkAuthenticationElement = elements.create("linkAuthentication");
    linkAuthenticationElement.mount(this.linkAuthenticationElementTarget);

    const paymentElementOptions = {
      layout: "tabs",
    };

    const paymentElement = elements.create("payment", paymentElementOptions);
    paymentElement.mount(this.paymentElementTarget);

    document
      .querySelector("#payment-form")
      .addEventListener("submit", handleSubmit);

    async function handleSubmit(e) {
      e.preventDefault();

      const { error } = await stripe.confirmPayment({
        elements,
        confirmParams: {
          return_url: returnUrl
        },
      });

      // This point will only be reached if there is an immediate error when
      // confirming the payment. Otherwise, your customer will be redirected to
      // your `return_url`. For some payment methods like iDEAL, your customer will
      // be redirected to an intermediate site first to authorize the payment, then
      // redirected to the `return_url`.
      if (error.type === "card_error" || error.type === "validation_error") {
        showMessage(error.message);
      } else {
        showMessage("An unexpected error occurred.");
      }
    }

    // Fetches the payment intent status after payment submission
    async function checkStatus() {
      const clientSecret = new URLSearchParams(window.location.search).get(
        "payment_intent_client_secret"
      );

      if (!clientSecret) {
        return;
      }

      const { paymentIntent } = await stripe.retrievePaymentIntent(
        clientSecret
      );

      switch (paymentIntent.status) {
        case "succeeded":
          showMessage("Payment succeeded!");
          break;
        case "processing":
          showMessage("Your payment is processing.");
          break;
        case "requires_payment_method":
          showMessage("Your payment was not successful, please try again.");
          break;
        default:
          showMessage("Something went wrong.");
          break;
      }
    }

    // ------- UI helpers -------

    function showMessage(messageText) {
      const messageContainer = document.querySelector("#payment-message");

      messageContainer.classList.remove("hidden");
      messageContainer.textContent = messageText;

      setTimeout(function () {
        messageContainer.classList.add("hidden");
        messageContainer.textContent = "";
      }, 4000);
    }
  }
}
