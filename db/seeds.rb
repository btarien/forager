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
Store.create!(name: 'Aldi', address: 'Schwanthalerstraße 14, 80336 München', url: 'https://www.aldi-sued.de/de/suchergebnis/produkte.html?search=', name_class: '.product-title', imgurl: 'aldi.png')
# Store.create!(name: 'Kaufland', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://www.kaufland.de/suche.assortmentSearch.html?searchsubmit=true&q=', name_class: '.m-offer-tile__title')
Store.create!(name: 'Edeka', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://e-center-knauer.edeka-shops.de/en/search?SearchTerm=', name_class: '.product-title', imgurl: 'edeka.png')
# Store.create!(name: 'Metro', address: 'Schwanthalerstraße 31, 80336 München', url: 'https://produkte.metro.de/shop/search?q=')

puts 'creating products and store-products...'
products = ['Joghurt', 'nudeln']

products.each do |product|
  puts "\n\n#{product.upcase}"
  Store.all.each do |store|
    puts "\n#{store.name.upcase}"
    file = Nokogiri::HTML(URI.open(store.url + product))
    count = 0
    file.search(store.name_class).each do |name|
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
        new_product = Product.new(
          name: product_name,
          brand: product_obj.brands,
          category: product,
          code: product_obj.code,
          nutriscore: product_obj.nutriscore_grade,
          nutrition: nutrition.to_json,
          ingredients: product_obj.ingredients_text,
          nutriscore_img: "nutriscore-#{product_obj.nutriscore_grade}.svg",
          product_img: product_obj.image_small_url
        )
        if new_product.save
          sp = StoreProduct.create!(product: new_product, store: store)
          count += 1
          puts "#{count}. #{sp.product.name}"
          break if count == 15
        else
          sp = StoreProduct.new(product: Product.find_by(name: product_name), store: store)
          if sp.save
            puts "\n#{product_name.upcase}\n"
            sp = StoreProduct.create!(product: Product.find_by(code: product_obj.code), store: store)
            count += 1
            puts "#{count}. #{sp.product.name}"
            break if count == 15
          end
        end
      end
    end
  end
end

StoreProduct.create!(product: Product.first, store: Store.second)
StoreProduct.create!(product: Product.second, store: Store.second)
StoreProduct.create!(product: Product.third, store: Store.second)

puts 'creating groceries...'
Grocery.create!(quantity: 2, user: User.first, store_product: StoreProduct.first)
Grocery.create!(quantity: 1, user: User.first, store_product: StoreProduct.second)
Grocery.create!(quantity: 6, user: User.first, store_product: StoreProduct.third)

puts 'creating favorites...'
Favorite.create!(product: Product.first, user: User.first)
Favorite.create!(product: Product.second, user: User.first)
