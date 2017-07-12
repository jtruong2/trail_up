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
end