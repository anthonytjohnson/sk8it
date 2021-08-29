class Dashboard::VideoPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.videos_as_owner
    end
  end
end
