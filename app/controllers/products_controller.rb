class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
   
    address = params[:address] || session[:search_location] 
    results = Geocoder.search(address) unless address.nil?
    if address.present? && results.present?
      session[:search_location] = address
      @coordinates = results.first.coordinates
    else
      flash.alert = "Please enter an address."
      redirect_to root_path
    end
    # convert address into latitude longitud
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
