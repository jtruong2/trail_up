class Events::SearchController < ApplicationController
  def index
    @events = Event.near(get_location, 30).map{ |event| EventPresenter.new(event)}
  end

  def get_location
    Geocoder.coordinates(params[:event_search])
  end
end