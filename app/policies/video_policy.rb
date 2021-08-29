class VideoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.videos
    end
  end

  def create?
    true
  end

  def upvote?
    true
  end
end
