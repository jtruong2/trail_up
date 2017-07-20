class FitbitController < ApplicationController

  def index
    codes = params[:id]
    FitbitService.new(params[:id], current_user).start_collection
    session[:fitbit] = true
    flash[:sucess] = ["Check out an event to see your Fitbit Data!"]
  end

end
