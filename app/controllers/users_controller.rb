class UsersController < ApplicationController
  before_action :authorize_user!

  def authorize_user
    authorize @user = current_user
  end
end
