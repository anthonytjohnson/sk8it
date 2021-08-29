class ReviewsController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.spot = @spot
    authorize @review
    if @review.save
      redirect_to @spot, notice: 'Review added!'
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
