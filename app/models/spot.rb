class Spot < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :videos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  validates :name, presence: true
  validates :address, presence: true
  validates :type, presence: true
  validates :name, uniqueness: true
end
