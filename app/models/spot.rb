class Spot < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :videos
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  CATEGORIES = ["spot", "shop"]
  validates :name, presence: true
  validates :address, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :name, uniqueness: true
  validates :description, length: { within: 10..140 }
end
