class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :comment, presence: true
  validates :rating, presence: true
  validates :comment, length: { within: 10..140 }
  validates :rating, numericality: { only_integer: true }
end
