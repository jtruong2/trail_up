class Events::SearchController < ApplicationController
  def index
    binding.pry
    render 'events/index'
  end
end