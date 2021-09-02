class FavoritesController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    @favorite = Favorite.create(user_id: current_user.id, spot_id: @spot.id)
  end
end
