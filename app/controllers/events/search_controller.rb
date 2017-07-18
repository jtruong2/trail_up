class Events::SearchController < ApplicationController
  include Location
  
  def index
    binding.pry
    @events = Event.send(params[:search_by].to_sym, search_params)
  end
  
  private

    def search_params
      {
        location: get_location,
        radius: get_radius,
        query: params[:event_search],
        end_date: params[:end_date].empty? ? params[:event_search] : params[:end_date],
      }  
    end
end