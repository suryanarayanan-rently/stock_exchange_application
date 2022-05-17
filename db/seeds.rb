require_relative "stock_seed.rb"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Started Seeding User data"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
User.create!(username:"admin@example.com",email: 'admin@example.comple', password:"password",password_confirmation:"password",name: "Admin", mobile:"8428169669")
Wallet.create!(username:"admin@example.com",balance:0.00)
puts "User data seeding completed"
seed_stock_data
Doorkeeper::Application.create(name:"Postman",redirect_uri:"",scopes:"")
puts "seeding completed"
