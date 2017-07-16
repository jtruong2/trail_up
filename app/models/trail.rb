class Trail < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :pictures, as: :imageable

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

  def get_pictures
    if self.pictures.empty?
      ['logo_trail_up.png']
    else
      self.pictures
    end
  end

  def coordinates
    [latitude, longitude]
  end
end
