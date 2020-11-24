# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Grocery.destroy_all
User.destroy_all
StoreProduct.destroy_all
Product.destroy_all
Store.destroy_all

User.create!(email: "test@test.com", password: "123456")

Product.create!(name: "Milk", brand: "Landliebe", nutriscore: "B")
Product.create!(name: "Cereal", brand: "Kellogs", nutriscore: "D")
Product.create!(name: "Apple", brand: "Bio", nutriscore: "A")

Product.create!(name: "Milk", brand: "Weihenstephan", nutriscore: "B")
Product.create!(name: "Porridge", brand: "Kellogs", nutriscore: "B")
Product.create!(name: "Banana", brand: "Chiquita", nutriscore: "A")

Store.create!(name: "Rewe", address: "Arnulfstraße 32, 80335 München")
Store.create!(name: "Lidl", address: "Elisenstraße 3, München")

StoreProduct.create!(price: 2.5, product: Product.first, store: Store.first)
StoreProduct.create!(price: 3.0, product: Product.second, store: Store.first)
StoreProduct.create!(price: 0.5, product: Product.third, store: Store.first)

StoreProduct.create!(price: 2.5, product: Product.fourth, store: Store.second)
StoreProduct.create!(price: 3.0, product: Product.fifth, store: Store.second)
StoreProduct.create!(price: 0.5, product: Product.sixth, store: Store.second)

Grocery.create!(quantity: 2, user: User.first, store_product: StoreProduct.first)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.second)
Grocery.create!(quantity: 6, user: User.first, store_product: StoreProduct.third)
Grocery.create!(quantity: 3, user: User.first, store_product: StoreProduct.fourth)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.fifth)
Grocery.create!(quantity: 4, user: User.first, store_product: StoreProduct.sixth)
