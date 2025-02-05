# frozen_string_literal: true

class ProductDecorator < SimpleDelegator
 
  def formatted_price
    master_variant&.price ? 
      ApplicationController.helpers.number_to_currency(master_variant.price) : 
      "Price not available"
  end

  # Retrieve non-master variants with optional filtering
  def available_variants(in_stock: true)
    in_stock ? variants.where('stock > 0') : variants
  end

  # Generate JSON representation of variants
  def variants_json
    available_variants.includes(variant_options: :option_value).map do |variant|
      {
        id: variant.id,
        price: variant.price,
        sku: variant.sku,
        stock: variant.stock,
        variant_options: variant.variant_options.map do |vo|
          option_value = vo.option_value
          {
            option_type: option_value&.option_type&.name,
            option_value: {
              id: option_value&.id,
              value: option_value&.value
            }
          }
        end
      }
    end.to_json
  end

  # Get option types for variants
  def option_types
    OptionType.joins(option_values: { variant_options: :product_variant })
              .where(variant_options: { product_variant_id: variants.pluck(:id) })
              .distinct
  end

  # Find matching variants for a specific option value
  def find_matching_variants(option_value)
    variants
      .joins(:variant_options)
      .where(variant_options: { option_value_id: option_value.id })
      .where.not(is_master: true)
      .where('stock > 0')
  end

  # Get primary variant image
  def primary_image_url
    master_variant&.images&.first&.url || 'default_product_image.png'
  end

  def name
    super.titleize
  end

end