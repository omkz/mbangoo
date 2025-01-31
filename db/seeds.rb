UserRole.delete_all
Role.delete_all
User.delete_all

admin_role = Role.find_or_create_by(name: "admin")
user_role = Role.find_or_create_by(name: "user")

admin = User.create!(
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password"
)
admin.roles << admin_role

user = User.create!(
  email: "user@example.com",
  password: "password",
  password_confirmation: "password"
)
user.roles << user_role


OrderStatus.delete_all
OrderStatus.create! id: 1, name: "pending"
OrderStatus.create! id: 2, name: "processing"
OrderStatus.create! id: 3, name: "failed"
OrderStatus.create! id: 4, name: "succeed"
