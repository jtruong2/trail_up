class Api::Trails::SearchController < ActionController::API

  def index
    @trails = TrailsPresenter.new(search_params)
    render json: @trails.collection
  end

  def search_params
    params.require(:search).permit( :lat, :lon, :sort,
                                    :maxDistance, :maxResults,
                                    :minLength )
  end
end