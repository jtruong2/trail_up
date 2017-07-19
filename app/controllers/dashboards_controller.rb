class DashboardsController < ApplicationController
  def show
    if current_user.admin?
      redirect_to admin_dashboard_index_path
    else
      @event_presenter = EventPresenter.collect_events(current_user)
    end
  end
end
