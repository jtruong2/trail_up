class EventPresenter
  attr_reader :name, :description, :trail
  def initialize(event)
    @trail = event.trail
    @name = event.name
    @description = event.description
    @date = event.date
  end

  def format_date
    date.strftime("%A %B %e %Y at %l:%M")
  end

  def trail_name
    trail.name
  end

  def location
    trail.location
  end

  private
  attr_reader :date
end
