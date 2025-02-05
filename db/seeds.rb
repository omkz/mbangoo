# User and Role Seeding
Role.destroy_all
UserRole.destroy_all
User.destroy_all

# Create Roles
admin_role = Role.create!(name: 'admin')
user_role = Role.create!(name: 'user')
vendor_role = Role.create!(name: 'vendor')

# Admin Users
admin_users = [
  {
    email: 'super_admin@example.com',
    name: 'Super Admin',
    password: 'password123',
    roles: [admin_role]
  },
  {
    email: 'admin@example.com',
    name: 'Main Administrator',
    password: 'password123',
    roles: [admin_role]
  }
]

admin_users.each do |user_data|
  user = User.create!(
    email: user_data[:email],
    # name: user_data[:name],
    password: user_data[:password],
    password_confirmation: user_data[:password]
  )

  user_data[:roles].each do |role|
    UserRole.create!(user: user, role: role)
  end
end

# Regular Users
regular_users = [
  {
    email: 'john_doe@example.com',
    name: 'John Doe',
    password: 'password123',
    roles: [user_role]
  },
  {
    email: 'jane_smith@example.com',
    name: 'Jane Smith',
    password: 'password123',
    roles: [user_role]
  }
]

regular_users.each do |user_data|
  user = User.create!(
    email: user_data[:email],
    # name: user_data[:name],
    password: user_data[:password],
    password_confirmation: user_data[:password]
  )

  user_data[:roles].each do |role|
    UserRole.create!(user: user, role: role)
  end
end

# Vendor Users
vendor_users = [
  {
    email: 'vendor1@example.com',
    name: 'Tech Vendor',
    password: 'password123',
    roles: [vendor_role]
  },
  {
    email: 'vendor2@example.com',
    name: 'Fashion Vendor',
    password: 'password123',
    roles: [vendor_role]
  }
]

vendor_users.each do |user_data|
  user = User.create!(
    email: user_data[:email],
    # name: user_data[:name],
    password: user_data[:password],
    password_confirmation: user_data[:password]
  )

  user_data[:roles].each do |role|
    UserRole.create!(user: user, role: role)
  end
end

puts "Users seeded successfully!"
puts "Total Users: #{User.count}"
puts "Roles Created: #{Role.pluck(:name)}"


# Products Seeding
# Clear existing data
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

puts "Seed data created successfully!"
puts "Product: #{product.name}"
puts "Variants: #{product.variants.count}"
puts "Option Types: #{product.option_types.count}"

#order status
OrderStatus.delete_all
OrderStatus.create! id: 1, name: "pending"
OrderStatus.create! id: 2, name: "processing"
OrderStatus.create! id: 3, name: "failed"
OrderStatus.create! id: 4, name: "succeed"