class SearchController << ActionController::API
  def index
    @trailheads = Trailhead.search_by(params[:search])
  end
end