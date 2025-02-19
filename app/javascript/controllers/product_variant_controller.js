import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="product-variant"
export default class extends Controller {
  static values = { id: Number };
  static targets = ["select", "variantId", "price", "submitButton"];

  fetchVariant() {
    const selectedOptions = this.selectedOptions();

    if (selectedOptions.includes("")) {
      this.priceTarget.innerText = "Select options to see price";
      this.submitButtonTarget.disabled = true;
      return;
    }

    const url = `/products/${this.idValue}/find_variant?option_values=${selectedOptions.join(",")}`;
    
    fetch(url)
      .then((response) => response.json())
      .then((data) => {
        if (data.variant_id) {
          this.variantIdTarget.value = data.variant_id;
          this.priceTarget.innerText = `Price: $${data.price}`;
          this.submitButtonTarget.disabled = false;
        } else {
          this.priceTarget.innerText = "Variant not available";
          this.submitButtonTarget.disabled = true;
        }
      })
      .catch((error) => {
        console.error("Error fetching variant:", error);
        this.priceTarget.innerText = "Error fetching price";
      });
  }

  selectedOptions() {
    return this.selectTargets.map((select) => select.value);
  }
}
