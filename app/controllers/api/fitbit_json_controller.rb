class Api::FitbitJsonController < ActionController::API

  def index
    redirect_to fitbit_index_path(:id => params[:codes])
  end
end
