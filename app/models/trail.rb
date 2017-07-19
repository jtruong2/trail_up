class Trail < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :pictures, as: :imageable
  accepts_nested_attributes_for :pictures

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode, on: [ :create ]

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.location = "#{geo.city}, #{geo.state}"
    end
  end

  validates :name, presence: true, uniqueness: true
  validates :description, :distance, presence: true
  has_many :events
  belongs_to :difficulty

  def get_pictures
    if pictures.empty?
      [OpenStruct.new(image: 'logo_trail_up.png')]
    else
      pictures
    end
  end

  def coordinates
    [latitude, longitude]
  end
end
