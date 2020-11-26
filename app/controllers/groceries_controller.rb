class GroceriesController < ApplicationController
  def index
    @all_stores = Store.all.map {|store| store.name }
    @groceries = Grocery.all
    @stores = []
    @groceries.each do |grocery|
      product = grocery.store_product.product
      shops = product.stores
      @stores << {product: grocery, store: shops}
  
    end
  end

  def create
    grocery_params = params["@grocery"]

    #if @grocery.nil?
      @grocery = Grocery.create(
        user: current_user,
        store_product: StoreProduct.where(product_id: grocery_params[:product_id].to_i).find_by(store_id: grocery_params[:store_id].to_i),
        quantity: 1
      )

      
   # else
     # grocery = Grocery.where(user: current_user, store_product: StoreProduct.find(params[:store_product_id])).last
    #  quantity = grocery.quantity + 1
    #  grocery.update(quantity: quantity)
    #end
  end
  def update
    grocery_params = params["grocery"]
    current_store = StoreProduct.where(product_id: grocery_params[:product_id].to_i).find_by(store_id: grocery_params[:current_store_id].to_i)
    current_store.update(in_grocery: false)
    new_store_product = StoreProduct.create!(product_id: grocery_params[:product_id].to_i, store_id: grocery_params[:store_id].to_i)
    @grocery = Grocery.create(
        user: current_user,
        store_product: new_store_product,
        quantity: 1
      )
  end
end
