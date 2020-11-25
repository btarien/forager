class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

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
