# db/seeds.rb
puts "Starting seed process..."

# Require seed files in order
require_relative 'seeds/01_users'
require_relative 'seeds/02_order_statuses'
require_relative 'seeds/03_categories'
require_relative 'seeds/04_products'

puts "Seed process completed!"