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

  def upvote
    # retrieve video by id
    @video = Video.find(params[:id])
    @spot = @video.spot
    authorize @video
    # retrieve current user
    @user = current_user
    # upvote video by current user
    if @user.nil?
      redirect_to new_user_session_path
    else
      @user.voted_up_on?(@video) ? @video.unliked_by(@user) : @video.liked_by(@user)
      # redirect back to show page
      redirect_to spot_path(@spot)
    end
  end

  private

  def video_params
    params.require(:video).permit(:caption, :video)
  end
end
