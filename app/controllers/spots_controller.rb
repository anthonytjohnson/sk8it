class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [ :home, :index, :show ]

  def show
    @spot = Spot.find(params[:id])
    @videos = Video.all
    authorize @spot
  end
end
