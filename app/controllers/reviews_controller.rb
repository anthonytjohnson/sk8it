class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @spot = Spot.find(params[:spot_id])
    @review.spot = @spot
    authorize @review
    if @review.save
      redirect_to spot_path(@spot), notice: 'Review added!'
    else
      redirect_to spot_path(@spot), notice: 'Review not added, min 10 characters'
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
