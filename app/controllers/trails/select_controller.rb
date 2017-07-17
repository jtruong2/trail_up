class Trails::SelectController < ApplicationController
  def index
    
  end

  def new
    binding.pry
    if current_user.nil? 
      binding.pry
      flash[:error] = ["You must be signed in to create an event!"]
      redirect_to login_path
    else
      trail = JSON.parse(params[:trail], symbolize_names: true)
      @new_trail = Trail.find_by(hp_id: trail[:hp_id]) ||
                  Trail.create(
                    hp_id: trail[:hp_id],
                    name: trail[:name],
                    description: trail[:summary],
                    location: trail[:location],
                    distance: trail[:length],
                    longitude: trail[:long],
                    latitude: trail[:lat],
                    rating: trail[:hp_rating],
                    difficulty: trail[:difficulty]
                  )
      if @new_trail.save
        redirect_to new_event_path(trail_id: @new_trail.id)
      else
        render new
      end
    end
  end
end
