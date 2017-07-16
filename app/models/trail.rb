class Trail < ApplicationRecord
  reverse_geocoded_by :latitude, :longitude

  after_validation :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.location = "#{geo.city}, #{geo.state}"
    end
  end
  after_validation :reverse_geocode
  
  validates :name, presence: true, uniqueness: true
  validates :description, :difficulty, :distance, :rating, presence: true
  has_many :events

  def coordinates
    [latitude, longitude]
  end
end
