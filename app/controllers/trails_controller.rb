class TrailsController < ApplicationController

  def index
    current_page = params[:page]|| 1
    per_page = 10
    @trails = TrailsPresenter.new
    @page_results = WillPaginate::Collection.create(current_page.to_i, per_page, @trails.collection.count) do |pager|
      start = (current_page.to_i-1)*per_page
      pager.replace(@trails.collection[start, per_page])
    end
  end

  def new
    @trail = Trail.new
  end

  def create
    @trail = Trail.new(trail_params)
    if @trail.save
      Picture.creat_many(pic_params[:images].merge({imageable_id: @trail.id})) if pic_params[:images][:images]
      if session[:making_event]
        flash[:success] = ["Trail Created"]
        redirect_to new_event_path(trail_id: @trail.id)
      else
        flash[:success] = ["Trail Created"]
        redirect_to trail_path(@trail)
      end
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
end
