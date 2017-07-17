class Api::FitbitController < ActionController::API

  def index
    redirect_to controller: 'fitbit', action: 'index', codes: params[:codes]
  end
end
