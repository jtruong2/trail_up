class Events::SearchController < ApplicationController
  def index
    location = get_location
    @events = Event.near(location, 20)
    binding.pry
    render 'events/index'
  end

  def get_location
    Geocoder.coordinates(params[:event_search])
  end
end