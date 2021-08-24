class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [ :home, :index, :show ]

  def show
    @spot = Spot.find(params[:id])
    authorize @spot
  end

  def new
    @spot = Spot.new
    authorize @spot
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    authorize @spot
    if @spot.save
      redirect_to @spot, notice: 'Spot added!'
    else
      render :new
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :category, :description)
  end
end
