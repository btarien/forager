class GroceriesController < ApplicationController
  def index
    @groceries = Grocery.all
  end

  def create
    if @grocery.nil?
      @grocery = Grocery.create(
        user: current_user,
        store_product: StoreProduct.find(params[:store_product_id]),
        quantity: 1
      )
    else
      grocery = Grocery.where(user: current_user, store_product: StoreProduct.find(params[:store_product_id])).last
      quantity = grocery.quantity + 1
      grocery.update(quantity: quantity)
    end
  end
end
