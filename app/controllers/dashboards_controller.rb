class DashboardsController < ApplicationController
  def show
    @event_presenter = EventPresenter.collect_events(current_user)
  end
end
