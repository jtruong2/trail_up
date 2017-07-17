class Trails::SelectController < ApplicationController
  def index
    
  end

  def new
    trail = JSON.parse(params[:trail], symbolize_names: true)
    new_trail = Trail.find_or_create_by(hp_id: trail[:hp_id]
    bind.pry  
  end

  def trail_params
    params.permit(:trail)
    
  end
end