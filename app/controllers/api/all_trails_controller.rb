class Api::AllTrailsController < ActionController::API
  def index
    @trails = TrailsPresenter.new(location_params)
    render json: @trails.collection
  end

  def location_params
    params.permit(:lat, :lng)
  end
end