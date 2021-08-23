class User < ApplicationRecord
  has_many :videos
  has_many :spots
  has_one_attached :photo

  validates :username, presence: true
  validates :username, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
