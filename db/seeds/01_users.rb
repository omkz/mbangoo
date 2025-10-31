# User and Role Seeding
UserRole.destroy_all
User.destroy_all
Role.destroy_all

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
