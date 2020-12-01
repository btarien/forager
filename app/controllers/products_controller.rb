class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    address = params[:address] || session[:search_location]
    results = Geocoder.search(address) unless address.nil?
    @gro_counter = Grocery.where(user: current_user).size
    if address.present? && results.present?
      session[:search_location] = address
      @coordinates = results.first.coordinates
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
    
    @markers = [] if @markers.nil?
    @markers << get_current_address(address) if address.present?
    p @markers
    hash_of_store_products
  end

  private

  def hash_of_store_products
    @hash = {}

    if params[:query].present?
      @store_products = StoreProduct.global_search(params[:query])
    end

    @store_products.each do |store_product|
      if @hash.keys.include? store_product.product
        @hash[store_product.product] << store_product.store
      else
        @hash[store_product.product] = [store_product.store]
      end
    end

    @hash
  end

  def get_current_address(address)
    results = Geocoder.search(address)
    coordinates = results.first.coordinates
    return {
      lat: coordinates.first,
      lng: coordinates.last,
      imageUrl: helpers.asset_url('map-marker.png')
    } 
  end
end
