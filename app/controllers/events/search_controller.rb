class Events::SearchController < ApplicationController
  def index
    location = get_location
    @events = Event.near(location, 30)
  end

  def get_location
    Geocoder.coordinates(params[:event_search])
  end
end