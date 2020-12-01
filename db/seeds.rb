require 'json'
require 'open-uri'
require 'nokogiri'
require 'openfoodfacts'

puts 'clearing db...'
Favorite.destroy_all
Grocery.destroy_all
User.destroy_all
StoreProduct.destroy_all
Product.destroy_all
Store.destroy_all

puts 'creating users...'
User.create!(email: "alice@example.com", password: "123456", image: 'https://source.unsplash.com/a7itXABwl8U/100x100')
User.create!(email: "bob@example.com", password: "123456", image: 'https://source.unsplash.com/8PMvB4VyVXA/100x100')

puts 'creating stores...'
Store.create!(name: 'Aldi', address: 'Schwanthalerstraße 14, 80336 München', url: 'https://www.aldi-sued.de/de/suchergebnis.html?search=', name_class: '.product-title')
Store.create!(name: 'Kaufland', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://www.kaufland.de/suche.assortmentSearch.html?searchsubmit=true&q=', name_class: '.m-offer-tile__title')
# Store.create!(name: 'Edeka', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://e-center-knauer.edeka-shops.de/en/search?SearchTerm=', name_class: '.m-offer-tile__title')
# Store.create!(name: 'Metro', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://produkte.metro.de/shop/search?q=')

puts 'creating products...'
products = ["Yogurt"]

products.each do |product|
  Store.all.each do |store|
    file = Nokogiri::HTML(URI.open(store.url + product))
    count = 0
    file.search(store.name_class).each do |name|
      count += 1
      break if count > 5
      product_name = name.content.strip
      product_name.gsub!(/\s\d.*/, '')
      product_obj = Openfoodfacts::Product.search(product_name).first
      unless product_obj.nil?
        product_obj = Openfoodfacts::Product.get(product_obj.code)
        nutriments = product_obj.nutriments.to_h
        nutrition = {
          calories: nutriments['energy-kcal_value'],
          fat: {
            total: nutriments['fat_100g'],
            saturated: nutriments['saturated-fat_100g'],
            trans: nutriments['trans-fat_100g'],
            polyunsaturated: nutriments['polyunsaturated-fat_100g'],
            monounsaturated: nutriments['monounsaturated-fat_100g']
          },
          carbohydrates: {
            total: nutriments['carbohydrates_100g'],
            sugar: nutriments['sugars'],
            fiber: nutriments['fiber']
          },
          protein: nutriments['proteins'],
          sodium: nutriments['sodium']
        }
        Product.create!(
          name: product_name,
          brand: product_obj.brands,
          nutriscore: product_obj.nutriscore_grade,
          nutrition: nutrition.to_json,
          ingredients: product_obj.ingredients_text,
          nutriscore_img: "nutriscore-#{product_obj.nutriscore_grade}.svg",
          product_img: product_obj.image_small_url
        )
      end
    end
  end
end

puts 'creating store-products...'
StoreProduct.create!(price: 2.5, product: Product.first, store: Store.first)
StoreProduct.create!(price: 3.0, product: Product.second, store: Store.first)
StoreProduct.create!(price: 0.5, product: Product.third, store: Store.first)
StoreProduct.create!(price: 2.5, product: Product.fourth, store: Store.second)
StoreProduct.create!(price: 3.0, product: Product.fifth, store: Store.second)
StoreProduct.create!(price: 0.5, product: Product.last, store: Store.second)
StoreProduct.create!(price: 0.5, product: Product.last, store: Store.first)

puts 'creating groceries...'
Grocery.create!(quantity: 2, user: User.first, store_product: StoreProduct.first)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.second)
Grocery.create!(quantity: 6, user: User.first, store_product: StoreProduct.third)

puts 'creating favorites...'
Favorite.create!(product: Product.first, user: User.first)
Favorite.create!(product: Product.second, user: User.first)
