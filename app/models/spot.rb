class Spot < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :videos
  has_one_attached :photo

  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :type, presence: true
  validates :name, uniqueness: true
  validates :description, length: { within: 10..140 }
end
