# Order Status Seeding
OrderStatus.destroy_all

OrderStatus.create! id: 1, name: "pending"
OrderStatus.create! id: 2, name: "processing"
OrderStatus.create! id: 3, name: "shipped"
OrderStatus.create! id: 4, name: "delivered"
OrderStatus.create! id: 5, name: "cancelled"

puts "Seeded #{OrderStatus.count} order statuses"
