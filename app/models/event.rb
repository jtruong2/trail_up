class Event < ApplicationRecord
  geocoded_by :trail_location
  after_validation :geocode


  belongs_to :trail
  validates :name, :description, :date, presence: true

  has_many :event_roles, dependent: :destroy
  has_many :users, through: :event_roles

  def trail_location
    trail.coordinates if trail
  end

  def coordinates
    [latitude, longitude]
  end
  
  def format_date
    date.strftime("%A %B %e %Y at %l:%M %P")
  end

  def hosts
    users.joins(:event_roles).where(event_roles: {role: "host"})
  end

  def guests
    users.joins(:event_roles).where(event_roles: {role: "guest"})
  end

  def user_status_change(params)
    if params[:status] == "Join"
      event_roles.create!(params.except(:status))
    else
      event_roles.where(user_id: params[:user_id]).destroy_all
    end
  end

  def self.to_presenter(results)
    results.map{ |event| EventPresenter.new(event)}
  end

  def self.by_name(params)
    query = sanitize_query(params[:query])
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
    query = sanitize_query(params[:query])
    results = Trail.find_by(name: params[:query]).events
    to_presenter(results)
  end

  def self.to_presenter(results)
    results.map{ |event| EventPresenter.new(event)}
  end
  
  def self.sanitize_query(query)
    query.gsub(/\w*((\%27)|(\'))((\%6F)|o|(\%4F))((\%72)|r|(\%52))/, '')
  end
end
