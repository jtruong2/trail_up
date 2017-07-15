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
    trail.coordinates if trail
  end

  def coordinates
    [latitude, longitude]
  end

  def self.by_name
    
  end

  def self.by_trail
    
  end

  def self.by_location(location, raidus)
    near(get_location, get_radius).map{ |event| EventPresenter.new(event)}
  end
end
