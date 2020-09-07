# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
quentin = User.create!(username: "Quentin", email: "tarantino@gmail.com")
josh = User.create!(username: "Josh", email: "jt@gmail.com")
ed = User.create!(username: "Ed", email: "ed@gmail.com")
larry = User.create!(username: "Larry", email: "larry@gmail.com")
frank = User.create!(username: "Frank", email: "frank@gmail.com")
phillip = User.create!(username: "Phillip", email: "phillip.strom@gmail.com")
annie = User.create!(username: "Annie", email: "aovolk@gmail.com")