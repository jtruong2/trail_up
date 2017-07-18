class EventsController < ApplicationController
  def new
    @event = Event.new(trail_id: params[:trail_id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      EventRole.create!(event_id: @event.id, user_id: current_user.id, role: 1)
      flash[:success] = ["Event Created"]
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @status = @event.user_event_status(current_user)
  end

  def status
    Event.change_user_event_role(current_user, params[:id][:status], params[:id][:event_id])
    redirect_to request.referrer
  end

  def destroy
    event = Event.find(params[:id]).destroy
    redirect_to root_path
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, "date(1i)", "date(2i)", "date(3i)", "date(4i)", "date(5i)").merge(trail_params)
    end

    def trail_params
      params.permit(:trail_id)
    end
end
