class Video < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  validates :caption, presence: true
end
