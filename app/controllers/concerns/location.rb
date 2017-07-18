module Location
  extend ActiveSupport::Concern

  def get_location
    Geocoder.coordinates(params[:event_search]) unless params[:event_search].empty?
  end

  def get_radius
    params[:radius] ? params[:radius] : 30
  end
end
