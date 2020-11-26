class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def create
    @favorite = Favorite.create(user: current_user, product_id: params[:product_id])
  end

end
