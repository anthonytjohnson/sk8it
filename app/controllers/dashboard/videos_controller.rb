class Dashboard::VideosController < ApplicationController
  def index
    @videos = policy_scope(Video)
    @videos_as_owner = policy_scope([:dashboard, Video])
    @comment = Comment.new
  end
end
