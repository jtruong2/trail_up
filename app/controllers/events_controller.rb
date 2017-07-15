class EventsController < ApplicationController
  def select_or_create_trail
    session[:redirect_to_new_event_page] = true
  end

  def new
    @event = Event.new(trail_id: params[:trail_id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      current_user.hosting << @event
      flash[:success] = ["Event Created"]
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, "date(1i)", "date(2i)", "date(3i)", "date(4i)", "date(5i)").merge(trail_params)
    end

    def trail_params
      params.permit(:trail_id)
    end
end
