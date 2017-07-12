class TrailsController < ApplicationController
  def index
    @trails = TrailsPresenter.new
  end
end