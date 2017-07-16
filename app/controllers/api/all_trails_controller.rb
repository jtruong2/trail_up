class Api::AllTrailsController < ActionController::API

  def index
    @trails = TrailsPresenter.new(search_params)
    render json: @trails.collection
  end

  def search_params
    params.require(:search).permit(:lat, :lon, :maxDistance)
  end
end