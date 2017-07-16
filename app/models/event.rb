class Event < ApplicationRecord
  geocoded_by :trail_location
  after_validation :geocode       

  belongs_to :trail
  validates :name, :description, :date, presence: true

  has_many :event_roles
  has_many :users, through: :event_roles

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
    binding.pry
    near(params[:location], params[:radius]).map{ |event| EventPresenter.new(event)}
  end

  def hosts
    users.joins(:event_roles).where(event_roles: {role: "host"})
  end

  def guests
    users.joins(:event_roles).where(event_roles: {role: "guest"})
  end
end
