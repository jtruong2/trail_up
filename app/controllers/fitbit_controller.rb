class FitbitController < ApplicationController

  def index
    codes = params[:id]
    results = FitbitService.new(params[:id], current_user).start_collection
    redirect_to fitbit_path(current_user.id)
  end

  def show
    @results = Fitbit.new(current_user).collect
    binding.pry
  end

  def login
  end

end
