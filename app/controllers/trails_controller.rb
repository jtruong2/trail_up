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
    @trail = Trail.create(trail_params)
    if @trail.save && session[:redirect_to_new_event_page]
      flash[:success] = ["Trail Created"]
      redirect_to new_event_path(trail_id: @trail.id)
      session[:redirect_to_new_event_page] = false
    elsif @trail.save && !session[:redirect_to_new_event_page]
      flash[:success] = ["Trail Created"]
      redirect_to trail_path(@trail)
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
end
