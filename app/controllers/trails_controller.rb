class TrailsController < ApplicationController
  include Referrer

  before_action :find_trail, only: [:show, :edit, :update]

  def index
  end

  def show
    @comment = Comment.new
    @comment.trail_id = @trail.id
    lat = Trail.find(params[:id]).latitude
    lon = Trail.find(params[:id]).longitude
    @weather = Weather.weather_info(lat, lon)
    @trails = Trail.all
  end

  def new
    session[:referrer] = request_referrer
    @trail = Trail.new
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save
      Picture.create_many(pic_params[:images].merge({imageable_id: @trail.id})) if pic_params[:images][:images]
      flash[:success] = ["Trail Created"]
      redirect_to select_redirect(session[:referrer], @trail)
    else
      flash[:error] = @trail.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @trail.update(trail_params)
      flash[:success] = ["Trail Updated"]
      redirect_to trail_path(@trail)
    else
      flash[:error] = @trail.errors.full_messages
      render :edit
    end
  end

  def addcomment
    respond_to do |format|
      format.js {render layout: false}
    end
  end


  private

  def find_trail
    @trail = Trail.find(params[:id])
  end

  def trail_params
    params.require(:trail).permit(:name, :description, :difficulty_id, :location, :lat, :lng, :distance, :rating)
  end

  def pic_params
    params.require(:trail).permit(images: [ :imageable_id, :imageable_type, { images: [] } ] )
  end
end
