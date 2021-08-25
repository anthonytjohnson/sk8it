class VideosController < ApplicationController
  def new
    @video = Video.new
    @spot = Spot.find(params[:spot_id])
    authorize @video
  end

  def create
    @video = Video.new(video_params)
    @spot = Spot.find(params[:spot_id])
    @video.user = current_user
    @video.spot = @spot
    authorize @video

    if @video.save
      redirect_to spot_path(@spot), notice: 'Video added!'
    else
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:caption, :video)
  end
end
