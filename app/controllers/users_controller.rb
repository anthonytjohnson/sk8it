class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    @comment = Comment.new
  end

  def authorize_user
    authorize @user = current_user
  end
end
