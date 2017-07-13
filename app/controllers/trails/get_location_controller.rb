class Trails::GetLocationController < ApplicationController

  def index
    session[:location] = location_param
    redirect_to new_trail_path
  end

  private

  def location_param
    { lat: params[:lat], lng: params[:lng] }
  end

end