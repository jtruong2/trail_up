class Trails::SelectController < ApplicationController
  include TrailSanitizer

  def index
  end

  def new
    if current_user.nil?
      flash[:error] = ["You must be signed in to create an event!"]
      redirect_to login_path
    else
      binding.pry
      @new_trail = Trail.find_by(hp_id: trail_params[:hp_id]) || Trail.create(trail_params)
      redirect_to new_event_path(trail_id: @new_trail.id)
    end
  end
end
