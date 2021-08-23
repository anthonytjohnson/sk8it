class Review < ApplicationRecord
  belongs_to :spot

  validate :comment, presence: true
end
