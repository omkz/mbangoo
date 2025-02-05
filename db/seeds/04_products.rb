ProductOptionType.destroy_all
VariantOption.destroy_all
ProductVariant.destroy_all
OptionValue.destroy_all
OptionType.destroy_all
Product.destroy_all

# Create Option Types
size_type = OptionType.create!(name: 'Size')
color_type = OptionType.create!(name: 'Color')

# Create Option Values
sizes = [
  size_type.option_values.create!(value: 'US 8'),
  size_type.option_values.create!(value: 'US 8.5'),
  size_type.option_values.create!(value: 'US 9')
]

colors = [
  color_type.option_values.create!(value: 'Red'),
  color_type.option_values.create!(value: 'Blue'),
  color_type.option_values.create!(value: 'Green')
]

# Create Product
product = Product.create!(
  name: 'Sample Sneakers',
  description: 'Comfortable and stylish sneakers',
  status: :active
)

# Attach images to the product
image_files = Dir.glob(Rails.root.join('db', 'seeds', 'images', '*.{jpg,jpeg,png,gif}'))
image_files.each do |image_path|
  begin
    product.images.attach(
      io: File.open(image_path),
      filename: File.basename(image_path),
      content_type: Marcel::MimeType.for(Pathname.new(image_path))
    )
  rescue => e
    puts "Error attaching image #{image_path}: #{e.message}"
  end
end

# Create Master Variant
master_variant = ProductVariant.create!(
  product: product,
  is_master: true,
  sku: 'SNEAKERS-MASTER',
  price: 99.99,
  stock: 100
)

# Create Product Variants with Options
variant_combinations = [
  { size: sizes[0], color: colors[0], price: 109.99, sku: 'SNEAKERS-US8-RED' },
  { size: sizes[0], color: colors[1], price: 114.99, sku: 'SNEAKERS-US8-BLUE' },
  { size: sizes[1], color: colors[0], price: 119.99, sku: 'SNEAKERS-US85-RED' },
  { size: sizes[1], color: colors[1], price: 124.99, sku: 'SNEAKERS-US85-BLUE' },
  { size: sizes[2], color: colors[2], price: 129.99, sku: 'SNEAKERS-US9-GREEN' }
]

variant_combinations.each do |combo|
  variant = ProductVariant.create!(
    product: product,
    is_master: false,
    sku: combo[:sku],
    price: combo[:price],
    stock: 50
  )

  # Create Variant Options
  VariantOption.create!(
    product_variant: variant,
    option_value: combo[:size]
  )

  VariantOption.create!(
    product_variant: variant,
    option_value: combo[:color]
  )
end

# Associate Option Types with Product
ProductOptionType.create!(
  product: product,
  option_type: size_type
)

ProductOptionType.create!(
  product: product,
  option_type: color_type
)

# Find categories
electronics = Category.find_by(name: 'Electronics')
smartphones = Category.find_by(name: 'Smartphones')
accessories = Category.find_by(name: 'Accessories')

# Associate product with categories
if electronics && smartphones && accessories
  product.categories << [
    electronics,    # Main Electronics category
    smartphones,    # Smartphones subcategory
    accessories     # Accessories subcategory
  ]
end

puts "Seed data created successfully!"
puts "Product: #{product.name}"
puts "Variants: #{product.variants.count}"
puts "Option Types: #{product.option_types.count}"
