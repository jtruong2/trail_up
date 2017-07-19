class Admin::TrailsController < Admin::BaseController

  def index
    @trails = Trail.all
  end

end
