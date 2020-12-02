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
        infoWindow: render_to_string(partial: "info_window", locals: { store: store }),
        imageUrl: helpers.asset_url(store.imgurl)

      }
    end
    
    @markers = [] if @markers.nil?
    @markers << get_current_address(address) if address.present?
    hash_of_store_products
  end

  private

  def hash_of_store_products
    @hash = {}
    nutri_scores = build_nutri_scores
    
    
    if params[:query].present?
      @store_products = StoreProduct.global_search(params[:query])
    else 
      @store_products = StoreProduct.all
    end

    if nutri_scores.any? 
      @store_products = @store_products.includes(:product).filter do |store_product| 
        nutri_scores.include? store_product.product.nutriscore
      end
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

  def build_nutri_scores
    nutri_hash = {
      "nutri_a" => "a",
      "nutri_b" => "b",
      "nutri_c" => "c",
      "nutri_d" => "d",
      "nutri_e" => "e"
    }
    filtered_params = params.permit(:query,:commit,:nutri_a,:nutri_b,:nutri_c,:nutri_d,:nutri_e).to_h.keys
    filtered_params.filter {|item| nutri_hash.key? item}.map {|item| nutri_hash[item]}
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
