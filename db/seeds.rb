UserRole.delete_all
Role.delete_all
User.delete_all
OptionType.delete_all
OptionValue.delete_all

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

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "pending"
OrderStatus.create! id: 2, name: "processing"
OrderStatus.create! id: 3, name: "failed"
OrderStatus.create! id: 4, name: "succeed"

size = OptionType.create!(name: "size")
size.option_values.create!(value: "US 8")
size.option_values.create!(value: "US 8.5")
size.option_values.create!(value: "US 9")

color = OptionType.create!(name: "color")   
color.option_values.create!(value: "black")
color.option_values.create!(value: "white")
color.option_values.create!(value: "red")
color.option_values.create!(value: "blue")
color.option_values.create!(value: "green")

material = OptionType.create!(name: "material")
material.option_values.create!(value: "powder")
material.option_values.create!(value: "whole bean")
material.option_values.create!(value: "ground")