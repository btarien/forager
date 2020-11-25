require 'json'

puts 'clearing db...'
Favorite.destroy_all
Grocery.destroy_all
User.destroy_all
StoreProduct.destroy_all
Product.destroy_all
Store.destroy_all

puts 'creating users...'
User.create!(email: "alice@example.com", password: "123456")
User.create!(email: "bob@example.com", password: "123456")

puts 'creating products...'
Product.create!(name: 'Skyr Style Mango',
  brand: 'Alpro',
  nutriscore: 'A',
  nutrition: {
    calories: 83,
    fat: {
      total: 3,
      saturated: nil,
      trans: nil,
      polyunsaturated: nil,
      monounsaturated: nil
    },
    carbohydrates: {
      total: 8.2,
      sugar: 8.1,
      fiber: 1.2
    },
    protein: 5.2,
    sodium: 0.26
  }.to_json,
  ingredients: "Soy base (water, peeled soy beans (13.9%)), sugar, mango (5%), passion fruit juice from fruit juice concentrate, stabilizer (pectins), acid regulators (sodium citrate, citric acid), tricalcium phosphate, sea salt, antioxidants (extracts with a high tocopherol content, fatty acid esters Ascorbic acid), flavors, vitamins (B2, B12, D2), yoghurt cultures (Str. Thermophilus, L. bulgaricus)."
)
Product.create!(name: 'Philadelphia Original',
  brand: 'Philadelphia',
  nutriscore: 'D',
  nutrition: {
    calories: 225,
    fat: {
      total: 21,
      saturated: 14,
      trans: nil,
      polyunsaturated: nil,
      monounsaturated: nil
    },
    carbohydrates: {
      total: 4.3,
      sugar: 4.3,
      fiber: 0.2
    },
    protein: 5.4,
    sodium: 0.75
  }.to_json,
  ingredients: "full fat soft cheese , salt, stabiliser (locust bean gum), acid (citric acid)"
)
Product.create!(name: 'Flatbreads everything good grains crackers',
  brand: 'Paskesz',
  nutriscore: 'D',
  nutrition: {
    calories: 412,
    fat: {
      total: 6.8,
      saturated: 1.1,
      trans: nil,
      polyunsaturated: nil,
      monounsaturated: nil
    },
    carbohydrates: {
      total: 74.9,
      sugar: 6.2,
      fiber: nil
    },
    protein: 5.4,
    sodium: 0.7
  }.to_json,
  ingredients: "Wheat flour, sesame seeds, extra virgin olive oil, onion powder, garlic powder, poppy seeds, water, salt, caraway seeds."
)

Product.create!(name: 'Red Bull',
  brand: 'Red Bull',
  nutriscore: 'E',
  nutrition: {
    calories: 46,
    fat: {
      total: 0,
      saturated: 0,
      trans: nil,
      polyunsaturated: nil,
      monounsaturated: nil
    },
    carbohydrates: {
      total: 11,
      sugar: 11,
      fiber: nil
    },
    protein: 0,
    sodium: 0.04
  }.to_json,
  ingredients: "water, sucrose, glucose, acidity regulators (sodium citrates, magnesium carbionate), carbon dioxide, acidifier (citric acid), taurine 0,4%, caffeine 0,03%, inositol, vitamins (niacin, pantothenic acid, vitamin b6, vitamin b12), flavourings, colours (caramel, riboflavin)"
)

Product.create!(name: 'PB2 The Original Powdered Peanut Butter',
  brand: 'Bell Plantation',
  nutriscore: 'D',
  nutrition: {
    calories: 462,
    fat: {
      total: 11.54,
      saturated: nil,
      trans: nil,
      polyunsaturated: nil,
      monounsaturated: 8.33
    },
    carbohydrates: {
      total: 38.46,
      sugar: 15.38,
      fiber: 7.7
    },
    protein: 46.15,
    sodium: 2.76
  }.to_json,
  ingredients: "Roasted peanuts, sugar and salt."
)

Product.create!(name: 'Organic Black Beans',
  brand: 'Trader Joe\'s',
  nutriscore: 'A',
  nutrition: {
    calories: 77,
    fat: {
      total: 0,
      saturated: 0,
      trans: 0,
      polyunsaturated: nil,
      monounsaturated: nil
    },
    carbohydrates: {
      total: 14.62,
      sugar: 0,
      fiber: 3.1
    },
    protein: 5.38,
    sodium: 0.108
  }.to_json,
  ingredients: "Organic black beans, water, sea salt."
)

puts 'creating stores...'
Store.create!(name: 'Rewe', address: 'Balanstraße 73, 81541 München')
Store.create!(name: 'Aldi', address: 'St.-Martin-Straße 57, 81669 München')
Store.create!(name: 'Edeka', address: 'Rosenheimer Str. 205, 81669 München')

puts 'creating store-products...'
StoreProduct.create!(price: 2.5, product: Product.first, store: Store.first)
StoreProduct.create!(price: 3.0, product: Product.second, store: Store.first)
StoreProduct.create!(price: 0.5, product: Product.third, store: Store.first)

StoreProduct.create!(price: 2.5, product: Product.fourth, store: Store.second)
StoreProduct.create!(price: 3.0, product: Product.fifth, store: Store.second)
StoreProduct.create!(price: 0.5, product: Product.all[5], store: Store.second)

Grocery.create!(quantity: 2, user: User.first, store_product: StoreProduct.first)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.second)
Grocery.create!(quantity: 6, user: User.first, store_product: StoreProduct.third)
Grocery.create!(quantity: 3, user: User.first, store_product: StoreProduct.fourth)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.fifth)
Grocery.create!(quantity: 4, user: User.first, store_product: StoreProduct.all[5])

