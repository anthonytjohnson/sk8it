class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [ :home, :index, :show ]

  def index
    @spots = policy_scope(Spot)
    if params[:query].present?
      sql_query = " \
      spots.name @@ :query \
      OR spots.description @@ :query \
      OR spots.category @@ :query \
      OR spots.address @@ :query \
      "
      @spots = Spot.where(sql_query, query: "%#{params[:query]}%")
    else
      @spots = policy_scope(Spot)
    end

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
    @video = Video.where(params[:spot_id])
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
    params.require(:spot).permit(:name, :address, :category, :description, photos:[])
  end
end
