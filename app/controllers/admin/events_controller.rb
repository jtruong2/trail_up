class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.joins(:trail).order('trails.location ASC')
  end
end
