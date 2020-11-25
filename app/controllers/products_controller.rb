class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @grocery = Grocery.new
    @store_products = StoreProduct.all
    @stores = Store.all
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
    hash_of_store_products
  end
    private
    def hash_of_store_products
      @hash = {}
        @store_products.each do |store_product|
          if @hash.keys.include? store_product.product
            @hash[store_product.product] << store_product.store
          else
            @hash[store_product.product] = [store_product.store]
          end
        end
      @hash
    end
end
