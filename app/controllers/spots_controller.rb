require 'exifr/jpeg'

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
    @top_video = @spot.videos.sort_by(&:votes).last
    @videos = @spot.videos.where.not(id: @top_video).order(created_at: :desc)
    authorize @spot
    @reviews = @spot.reviews
    @review = Review.new
    @video = Video.new
    @comment = Comment.new
  end

  def new
    @spot = Spot.new
    authorize @spot
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    authorize @spot
    if @spot.address.blank?
     gps_latitude = MiniMagick::Image.open(spot_params[:photos][0].tempfile.path).exif["GPSLatitude"]
     result = gps_latitude.split(',')
      latitude_sum = (result[0].split("/")[0].to_i) + ((result[1].split("/")[0].to_i)/60.0) +  (((result[2].split("/")[0].to_i)/(result[2].split("/")[1]).to_f)/3600.0)
      @spot.latitude = latitude_sum
       result = gps_latitude.split(',')
      latitude_sum = (result[0].split("/")[0].to_i) + ((result[1].split("/")[0].to_i)/60.0) +  (((result[2].split("/")[0].to_i)/(result[2].split("/")[1]).to_f)/3600.0)
      @spot.latitude = latitude_sum
      gps_longitude = MiniMagick::Image.open(spot_params[:photos][0].tempfile.path).exif["GPSLongitude"]
      result = gps_longitude.split(',')
      longitude_sum = (result[0].split("/")[0].to_i) + ((result[1].split("/")[0].to_i)/60.0) +  (((result[2].split("/")[0].to_i)/(result[2].split("/")[1]).to_f)/3600.0)
      @spot.longitude = longitude_sum
      @spot.address = @spot.reverse_geocode
      respond_to do |format|
        format.html
        format.js
      end
      @spot.address = @spot.reverse_geocode
    else
      if @spot.save
        redirect_to @spot, notice: 'Spot added!'
      else
        redirect_to @spot, notice: 'Spot added!'
      end
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :category, :description, photos:[])
  end
end
