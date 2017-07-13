class EventsController < ApplicationController
  def select_or_create_trail
    session[:redirect_to_new_event_page] = true
  end

  def new
    @event = Event.new(trail_id: params[:trail_id])
  end

  def create
    @event = Event.new(event_params)
    @event.trail_id = trail_params_id
    @event.user_id = current_user.id
    @event.save
    redirect_to event_path(@event)
  end

  def show
    @event = Event.find(params[:id])
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, "date(1i)", "date(2i)", "date(3i)", "date(4i)", "date(5i)")
    end

    def trail_params_id
      params.require(:trail_id)
    end
end
