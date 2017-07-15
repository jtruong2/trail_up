class Events::SearchController < ApplicationController
  def index
    binding.pry
    @events = Event.send(params[:search_by].to_symb, get_location, get_radius )
    # @events = Event.near(get_location, get_radius).map{ |event| EventPresenter.new(event)}
  end
  
  private
    def get_location
      Geocoder.coordinates(params[:event_search]) unless params[:event_search].empty?
    end

    def get_radius
      params[:radius] ? params[:radius] : 30
    end
end