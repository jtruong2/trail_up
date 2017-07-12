class Api::AllTrailsController < ActionController::API
  def index
    @trails = TrailsPresenter.new
    render json: @trails.collection
  end
end