class EventPresenter
  attr_reader :name, :description, :trail, :event_id, :archived, :user_id, :date
  def initialize(event, user = nil)
    @trail = event.trail
    @name = event.name
    @description = event.description
    @date = event.date
    @event_id = event.id
    @archived = event.archived
    @user_id = user.id if user
  end

  def format_date
    date.strftime("%A %B %e %Y at %l:%M %P")
  end

  def trail_name
    trail.name
  end

  def location
    trail.location
  end

  def self.collect_events(user)
    user.events.map { |event| EventPresenter.new(event, user) }
  end

  def get_identifiers
    "#{self.past_or_upcoming} #{self.host_or_guest}"
  end

  def past_or_upcoming
    return "past" if self.archived == true
    return "upcoming" if self.archived == false
  end

  def host_or_guest
    event = EventRole.find_by_sql("SELECT event_roles.role
                                   FROM event_roles
                                   WHERE event_roles.event_id = #{self.event_id}
                                   AND event_roles.user_id = #{self.user_id};")
    event[0].role
  end
end
