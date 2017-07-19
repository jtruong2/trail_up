class Events::EventStatusController < ApplicationController

  def index
    event = current_user.events.find(params[:id])
    event.update(archived: true)
    event.save
    redirect_to dashboard_path
  end
end
