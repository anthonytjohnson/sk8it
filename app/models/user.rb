class User < ApplicationRecord
  belongs_to :spot, optional: true
  has_many :videos
  has_many :spots
  has_one_attached :photo
  has_many :videos_as_owner, through: :spots, source: :videos

  validates :username, presence: true
  validates :username, uniqueness: true

  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
