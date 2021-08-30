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
      # next line will use the ruby gem to count votes
      # @user.voted_up_on?(@video) ? @video.unliked_by(@user) : @video.liked_by(@user)
      # next line will count the votes variable on the video
      # @user.voted_up_on?(@video) ? @video.votes -= 1 : @video.votes += 1
      if @user.voted_up_on?(@video)
        @video.unliked_by(@user)
        @video.votes -= 1
      else
        @video.liked_by(@user)
        @video.votes += 1
      end
      @video.save
      # redirect back to show page
      redirect_to spot_path(@spot, anchor: "video-#{@video.id}")
    end
  end

  private

  def video_params
    params.require(:video).permit(:caption, :video, :votes)
  end
end
