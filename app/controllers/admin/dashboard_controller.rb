class Admin::DashboardController < Admin::BaseController
  def index
    @admin_dash = AdminDashboardPresenter.new
  end
  
end