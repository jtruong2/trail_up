class Events::SearchController < ApplicationController
  def index
    @events = Event.send(params[:search_by].to_sym, search_params)
  end
  
  private

    def search_params
      {
        location: get_location,
        radius: get_radius,
        query: params[:event_search],
      }  
    end

    def get_location
      Geocoder.coordinates(params[:event_search]) unless params[:event_search].empty?
    end

    def get_radius
      params[:radius] ? params[:radius] : 30
    end
end