class Admin::TrailsController < Admin::BaseController

  def index
    @trails = Trail.order(:name)
  end

end
