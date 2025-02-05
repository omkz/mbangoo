# Categories and Product Categories Seeding
ProductCategory.destroy_all
Category.destroy_all

# Root Categories
electronics = Category.create!(
  name: 'Electronics',
  description: 'Electronic devices and accessories'
)

clothing = Category.create!(
  name: 'Clothing',
  description: 'Apparel and fashion items'
)

sports = Category.create!(
  name: 'Sports & Outdoors',
  description: 'Sports equipment and outdoor gear'
)

# Electronics Subcategories
smartphones = Category.create!(
  name: 'Smartphones',
  description: 'Mobile phones and smart devices',
  parent: electronics
)

laptops = Category.create!(
  name: 'Laptops',
  description: 'Portable computers and notebooks',
  parent: electronics
)

accessories = Category.create!(
  name: 'Accessories',
  description: 'Electronic accessories and peripherals',
  parent: electronics
)

# Clothing Subcategories
mens_clothing = Category.create!(
  name: 'Men\'s Clothing',
  description: 'Clothing for men',
  parent: clothing
)

womens_clothing = Category.create!(
  name: 'Women\'s Clothing',
  description: 'Clothing for women',
  parent: clothing
)

# Sports Subcategories
fitness_equipment = Category.create!(
  name: 'Fitness Equipment',
  description: 'Exercise and training gear',
  parent: sports
)

outdoor_gear = Category.create!(
  name: 'Outdoor Gear',
  description: 'Camping, hiking, and adventure equipment',
  parent: sports
)

# Detailed Subcategories
mens_shirts = Category.create!(
  name: 'Men\'s Shirts',
  description: 'Shirts and tops for men',
  parent: mens_clothing
)

mens_pants = Category.create!(
  name: 'Men\'s Pants',
  description: 'Trousers and pants for men',
  parent: mens_clothing
)

puts "Seeded #{Category.count} categories"