class Comment < ApplicationRecord
  belongs_to :video

  validates :comment, presence: true
end
