class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [ :home, :index, :show ]
  before_action :set_spot, only: [:show, :edit, :update, :destroy]

  def index
    @spots = policy_scope(Spot)
    @markers = @spots.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude
        # info_window: render_to_string(partial: "info_window", locals: { spot: spot }),
        # image_url: helpers.asset_url("sockspink.png")
      }
    end
  end

  def show
    @spot = Spot.find(params[:id])
    authorize @spot
  end
end
