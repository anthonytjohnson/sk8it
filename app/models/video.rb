class Video < ApplicationRecord
  belongs_to :user
  belongs_to :spot
  has_one_attached :video

  validates :caption, presence: true

  acts_as_votable
end
