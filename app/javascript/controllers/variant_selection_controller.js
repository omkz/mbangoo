// app/javascript/controllers/variant_selection_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    'variantRadio', 
    'selectedVariantId', 
    'dynamicPrice', 
    'dynamicStock', 
    'selectedVariantSku', 
    'variantSelectionError',
    'quantityInput'
  ]

  static values = {
    basePrice: Number,
    variants: Array
  }

  connect() {
    this.updateSelectedVariant()
  }

  updateSelectedVariant() {
    const selectedOptions = this.collectSelectedOptions()
    const matchingVariant = this.findMatchingVariant(selectedOptions)

    if (matchingVariant) {
      this.selectedVariantIdTarget.value = matchingVariant.id
      this.updatePrice(matchingVariant)
    } else {
      this.selectedVariantIdTarget.value = ''
      this.resetPrice()
    }
  }

  collectSelectedOptions() {
    const selectedOptions = {}
    this.variantRadioTargets.forEach(radio => {
      if (radio.checked) {
        selectedOptions[radio.dataset.optionType] = radio.dataset.optionValue
      }
    })
    return selectedOptions
  }

  findMatchingVariant(selectedOptions) {
    return this.variantsValue.find(variant => {
      const variantOptionValues = variant.variant_options.map(vo => vo.option_value.value)
      return Object.values(selectedOptions).every(selectedValue =>
        variantOptionValues.includes(selectedValue)
      ) && variant.stock > 0
    })
  }

  updatePrice(variant) {
    const quantity = parseInt(this.quantityInputTarget.value) || 1
    const totalPrice = variant.price * quantity

    this.dynamicPriceTarget.textContent = `$${totalPrice.toFixed(2)}`
    this.selectedVariantSkuTarget.textContent = `Variant: ${variant.sku}`
    this.dynamicStockTarget.textContent = `${variant.stock} in stock`
    this.variantSelectionErrorTarget.textContent = ''
  }

  resetPrice() {
    const quantity = parseInt(this.quantityInputTarget.value) || 1
    const totalPrice = this.basePriceValue * quantity

    this.dynamicPriceTarget.textContent = `$${totalPrice.toFixed(2)}`
    this.selectedVariantSkuTarget.textContent = ''
    this.dynamicStockTarget.textContent = 'Select variant'
    this.variantSelectionErrorTarget.textContent = 'No variant available for selected options.'
  }

  quantityChanged() {
    const selectedVariantId = this.selectedVariantIdTarget.value
    const selectedVariant = this.variantsValue.find(v => v.id.toString() === selectedVariantId)

    if (selectedVariant) {
      this.updatePrice(selectedVariant)
    } else {
      this.resetPrice()
    }
  }
}