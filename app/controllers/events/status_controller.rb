class Events::StatusController < ApplicationController
  def update
    Event.change_user_event_role(status_params)
    redirect_to request.referrer
  end

  def status_params
    params.permit(:status, :event_id).merge(user_id: current_user.id)
  end
end