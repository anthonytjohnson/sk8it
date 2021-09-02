class UsersController < ApplicationController
  before_action :authorize_user, only: :update
  def show
    @user = User.find(params[:id])
    authorize @user
    @comment = Comment.new

    favorites = Like.where(user_id: current_user.id).order(created_at: :desc).pluck(:spot_id)
    @favorites = Spot.find(favorites)
  end

  def update
    @user.update(user_params)
  end

  private

  def authorize_user
    authorize @user = current_user
  end

  def user_params
    params.require(:user).permit(:spot_id)
  end
end
