puts 'clearing db...'
Favorite.destroy_all
Grocery.destroy_all
StoreProduct.destroy_all
Product.destroy_all
Store.destroy_all

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
  },
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
  },
  ingredients: "full fat soft cheese , salt, stabiliser (locust bean gum), acid (citric acid)"
)

puts 'creating stores...'
Store.create!(name: 'Rewe', address: 'Balanstraße 73, 81541 München')
Store.create!(name: 'Aldi', address: 'St.-Martin-Straße 57, 81669 München')
Store.create!(name: 'Edeka', address: 'Rosenheimer Str. 205, 81669 München')

puts 'creating store-products...'
# Alpro yogurt in Rewe
sp = StoreProduct.new(price: 3.25)
sp.product = Product.first
sp.store = Store.first
sp.save!
# Alpro yogurt in Edeka
sp = StoreProduct.new(price: 3.25)
sp.product = Product.first
sp.store = Store.last
sp.save!
# Philadelphia cream cheese in Edeka
sp = StoreProduct.new(price: 4.32)
sp.product = Product.last
sp.store = Store.last
sp.save!

