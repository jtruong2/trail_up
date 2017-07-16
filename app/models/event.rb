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

  def self.by_name(params)
    where("name LIKE ?", "%#{params[:query]}%").map{ |event| EventPresenter.new(event)}
  end

  def self.by_date(params)
    date = params[:query].to_date
    where(:date => date.beginning_of_day..date.end_of_day).map{ |event| EventPresenter.new(event)}
  end

  def self.by_location(params)
    near(params[:location], params[:radius]).map{ |event| EventPresenter.new(event)}
  end
end
