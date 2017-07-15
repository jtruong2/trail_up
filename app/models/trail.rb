class Trail < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  after_validation :reverse_geocode
  
  validates :name, presence: true, uniqueness: true
  validates :description, :difficulty, :location, :distance, :rating, presence: true
  has_many :events
end
