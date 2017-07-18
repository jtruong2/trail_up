class Events::StatusController < ApplicationController
  def update
    Event.change_user_event_role(current_user, params[:status], params[:event_id])
    redirect_to request.referrer
  end
end