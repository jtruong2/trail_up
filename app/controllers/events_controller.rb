class EventsController < ApplicationController
  def select_or_create_trail
    session[:redirect_to_new_event_page] = true
  end

  def new
    @event = Event.new(trail_id: params[:trail_id])
  end
end
