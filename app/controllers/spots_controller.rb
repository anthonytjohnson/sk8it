class SpotsController < ApplicationController
  before_action :authenticate_user!, except: [ :home, :index, :show ]

  def index
    @spots = policy_scope(Spot)
    if params[:spot].present? && params[:query].present?
      sql_query = " \
      (spots.name @@ :query \
      OR spots.description @@ :query \
      OR spots.address @@ :query \)
      AND spots.category @@ :spot \
      "
      @spots = Spot.where(sql_query, query: "%#{params[:query]}%", spot: "%#{params[:spot]}%")
      if @spots.empty?
        @spots = policy_scope(Spot)
      end

    elsif params[:spot].present?
      sql_query = " \
      spots.category @@ :spot \
      "
      @spots = Spot.where(sql_query, spot: "%#{params[:spot]}%")


  elsif params[:shop].present? && params[:query].present?
      sql_query = " \
      (spots.name @@ :query \
      OR spots.description @@ :query \
      OR spots.address @@ :query \)
      AND spots.category @@ :shop \
      "

      @spots = Spot.where(sql_query, shop: "%#{params[:shop]}%", query: "%#{params[:query]}%")
      if @spots.empty?
        @spots = policy_scope(Spot)
      end

    elsif params[:shop].present?
      sql_query = " \
      spots.category @@ :shop \
      "
      @spots = Spot.where(sql_query, shop: "%#{params[:shop]}%")

    elsif params[:query].present?
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
        lng: spot.longitude,
        info_window: render_to_string(partial: "info_window", locals: { spot: spot })
      }
    end
  end

  def show
    @spot = Spot.find(params[:id])
    @top_video = @spot.videos.sort_by(&:weighted_score).last
    @videos = @spot.videos.where.not(id: @top_video).order(created_at: :desc)
    authorize @spot
    @reviews = @spot.reviews
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
