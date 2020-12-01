class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    @gro_counter = Grocery.where(user: current_user).size
  end
  def create
    @favorite = Favorite.create(user: current_user, product_id: params["@favorite"][:product_id].to_i)
  end

  def destroy
    Favorite.find(params[:id]).destroy
    redirect_to favorites_path
  end

end
