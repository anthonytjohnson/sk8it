class UsersController < ApplicationController
  before_action :authorize_user, only: :update
  def show
    @user = User.find(params[:id])
    authorize @user
    @comment = Comment.new
    if current_user
      favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:spot_id)
      @favorites = Spot.find(favorites)
    end
  end

  def update
    @user.update(user_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def authorize_user
    authorize @user = current_user
  end

  def user_params
    params.require(:user).permit(:spot_id)
  end
end
