class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    address = params[:address]
    results = Geocoder.search(address)
    # binding.pry
    if results.present?
      @coordinates = results.first.coordinates
    else
      flash.alert = "Please enter an address."
      redirect_to root_path
    end
    # convert address into latitude longitude
    # @coordinates = [address.longitude, address.latitude]
    # in the view, read these @coordinates
    @all_groceries = Grocery.where(user: current_user)
    @all_favorites = Favorite.where(user: current_user)
    @grocery = Grocery.new
    @store_products = StoreProduct.all
    @stores = Store.all
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { store: store })
      }
    end
    @hash = StoreProduct.hash_of_store_products
  end
end
