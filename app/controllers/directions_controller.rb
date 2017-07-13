class DirectionsController < ApplicationController
  def index
    @coords = Coordinates.new(direction_params)
  end

  def direction_params
    params.permit(:orig_lat, :orig_lng, :dest_lat, :dest_lng)
  end
end