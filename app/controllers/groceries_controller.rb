class GroceriesController < ApplicationController
  before_action :gro_params_map_page, only: [:create]
  def index
    @all_stores = []

    @groceries = Grocery.all
    @groceries.each do |g|
      @all_stores << g.store_product.store.name
    end
    @all_stores = @all_stores.uniq
    @all_favorites = Favorite.where(user: current_user)
    @stores = []
    @groceries.each do |grocery|
      product = grocery.store_product.product
      shops = product.stores
      @stores << { product: grocery, store: shops }
    end
  end

  def create
    grocery_params = params["@grocery"]

    @grocery = Grocery.create(
      user: current_user,
      store_product: StoreProduct.where(product_id: params["@grocery"][:product_id].to_i).find_by(store_id: params["@grocery"][:store_id].to_i),
      quantity: 1
    )
  end

  def update
    grocery_params = groceries_params
    strproduct = StoreProduct.find_by(product_id: grocery_params[:product_id], store_id: grocery_params[:store_id])
    Grocery.find(grocery_params[:grocery_id]).update!(store_product: strproduct)
    redirect_to groceries_path
  end

  def destroy
    Grocery.find(params[:id]).destroy
    redirect_to groceries_path
  end

  private

  def groceries_params
    params.require(:grocery).permit(:store_id, :product_id, :current_store_id, :grocery_id)
  end

  def gro_params_map_page
    params.require(:@grocery).permit(:store_id, :product_id)
  end
end
