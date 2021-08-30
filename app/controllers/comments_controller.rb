class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @video = Video.find(params[:video_id])
    @comment.user = current_user
    @spot = video.spot
    @comment.video = @video
    authorize @comment

    if @comment.save
      redirect_to spot_path(@spot), notice: 'Comment added!'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :video_id)
  end
end
