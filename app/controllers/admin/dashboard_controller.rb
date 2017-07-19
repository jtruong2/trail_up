class Admin::DashboardController < Admin::BaseController
  def index
    @events = Event.order(:date)
    @trails = Trail.order(:name)
    @users = User.order(:role)
  end
end