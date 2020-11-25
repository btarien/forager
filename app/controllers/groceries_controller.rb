class GroceriesController < ApplicationController
  def index
    @groceries = Grocery.all
  end

  def create
    if @grocery.nil?
      @grocery = Grocery.create(
        user: current_user,
        store_product: StoreProduct.where(product_id: params["@grocery"][:product_id].to_i).find_by(store_id: params["@grocery"][:store_id].to_i),
        quantity: 1
      )
    else
      grocery = Grocery.where(user: current_user, store_product: StoreProduct.find(params[:store_product_id])).last
      quantity = grocery.quantity + 1
      grocery.update(quantity: quantity)
    end
  end
end
