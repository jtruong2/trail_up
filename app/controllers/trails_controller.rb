class TrailsController < ApplicationController
  include Referrer

  def index
  end

  def show
    @trail = Trail.find(params[:id])
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
    @trail = Trail.find(params[:id])
  end

  def update
    @trail = Trail.find(params[:id])

    if @trail.update(trail_params)
      flash[:success] = ["Trail Updated"]
      redirect_to select_redirect(session[:referrer], @trail)
    else
      flash[:error] = @trail.errors.full_messages
      render :edit
    end
  end

  private

    def trail_params
      params.require(:trail).permit(:name, :description, :difficulty_id, :location, :distance, :rating)
    end

    def pic_params
      params.require(:trail).permit(images: [ :imageable_id, :imageable_type, { images: [] } ] )
    end
end
