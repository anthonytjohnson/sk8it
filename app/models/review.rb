class Review < ApplicationRecord
  belongs_to :spot

  validates :comment, presence: true
  validates :rating, presence: true
  validates :comment, length: { within: 10..500 }
  validates :rating, numericality: { only_integer: true }
end
