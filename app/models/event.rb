class Event < ApplicationRecord
  geocoded_by :trail_location
  after_validation :geocode       

  belongs_to :trail
  validates :name, :description, :date, presence: true

  has_many :event_guests
  has_many :guests, :through => :event_guests, source: :guest

  has_many :event_hosts
  has_many :hosts, :through => :event_hosts, source: :host



  def trail_location
    trail.location if trail
  end
end
