class EventsController < ApplicationController
  def new
    @event = Event.new(trail_id: params[:trail_id])
  end


  def create
    @event = Event.new(event_params)
    if @event.save
      current_user.event_roles.create!(event_id: @event.id, role: 1)
      flash[:success] = ["Event Created"]
      redirect_to event_path(@event)
    else
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    if @event.save
      redirect_to event_path(@event)
    else
      render :new
    end
  end


  def show
    @event = Event.find(params[:id])
    @status = current_user ? current_user.event_status(@event.id) : "unauthorized"
  end

  def destroy
    current_user.hosting.where(id: params[:id]).destroy_all
    redirect_to root_path
  end

  private
    def event_params
      params.require(:event).permit(:name, :description, :date, "date(1i)", "date(2i)", "date(3i)", "date(4i)", "date(5i)").merge(trail_params)
    end

    def trail_params
      params.permit(:trail_id)
    end
end
