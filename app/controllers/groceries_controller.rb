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
    grocery_params = groceries_params
    strproduct = StoreProduct.find_by(product_id: grocery_params[:product_id], store_id: grocery_params[:store_id])
    Grocery.find(grocery_params[:grocery_id]).update!(store_product: strproduct)
    redirect_to groceries_path
  end

  def destroy
    gro_to_delete = Grocery.find(params[:id]).destroy

    redirect_to groceries_path
  end
  private

  def groceries_params
    params.require(:grocery).permit(:store_id, :product_id, :current_store_id, :grocery_id)
  end
end
