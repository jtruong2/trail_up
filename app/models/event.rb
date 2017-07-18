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
    results = where("name LIKE ?", "%#{params[:query]}%")
    to_presenter(results)
  end

  def self.by_date(params)
    start_date = params[:query].to_date
    end_date = params[:end_date] ? params[:end_date].to_date : start_date
    results = where(:date => start_date.beginning_of_day..end_date.end_of_day)
    to_presenter(results)
  end

  def self.by_location(params)
    results = near(params[:location], params[:radius])
    to_presenter(results)
  end

  def self.by_trail(params)
   results = Trail.find_by(name: params[:query]).events
   to_presenter(results)
  end

  def hosts
    users.joins(:event_roles).where(event_roles: {role: "host"})
  end

  def guests
    users.joins(:event_roles).where(event_roles: {role: "guest"})
  end

  def self.to_presenter(results)
    results.map{ |event| EventPresenter.new(event)}
  end

  def user_status(user)
    return "unauthorized" if user == nil
    return "authorized" if is_host?(user) == false && is_guest?(user) == false
    return "guest" if is_guest?(user) == true
    return "host" if is_host?(user) == true
  end

  def is_host?(user)
    output = false
    self.hosts.each do |host|
      if host.id == user.id
        output = true
      end
    end
    output
  end

  def is_guest?(user)
    output = false
    self.guests.each do |guest|
      if guest.id == user.id
        output = true
      end
    end
    output
  end
end
