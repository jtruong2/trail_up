class TrailsController < ApplicationController
  before_action :request_referrer, only: [:new]

  def index
  end

  def new
    session[:referrer] = @referrer
    @trail = Trail.new
  end

  def create
    binding.pry
    @trail = Trail.new(trail_params)
    if @trail.save
      Picture.creat_many(pic_params[:images].merge({imageable_id: @trail.id})) if pic_params[:images][:images]
        flash[:success] = ["Trail Created"]
        redirect_to create_redirect(session[:referrer], @trail)
    else
      flash[:error] = @trail.errors.full_messages
      render :new
    end
  end

  def show
    @trail = Trail.find(params[:id])
  end

  private

    def trail_params
      params.require(:trail).permit(:name, :description, :difficulty, :location, :distance, :rating)
    end

    def pic_params
      params.require(:trail).permit(images: [ :imageable_id, :imageable_type, { images: [] } ] )
    end

    def request_referrer
      @referrer = Rails.application.routes.recognize_path(request.referrer)[:controller]
    end

    def create_redirect(referrer, trail)
      if referrer == "trails/select"
        new_event_path(trail_id: trail.id)
      else
        trail_path(trail)
      end
    end
end
