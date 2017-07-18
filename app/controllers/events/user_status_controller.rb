class Events::UserStatusController < ApplicationController
  def update
    event = Event.find(params[:event_id])
    event.user_status_change(status_params)
    flash[:success] = ["Event Status Updated"]
    redirect_to request.referrer
    
  end

  def status_params
    params.permit(:status).merge(user_id: current_user.id)
  end
  
end