class ProductsController < ApplicationController
  def index
    @products = Product.all
    @stores = Store.all

    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude
      }
    end
  end
end
