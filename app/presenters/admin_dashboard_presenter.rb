class AdminDashboardPresenter
  attr_reader :events, :trails, :users
  def initialize
    @events ||= Event.order(:date)
    @trails ||= Trail.order(:name)
    @users ||= User.order(:role)
  end
end