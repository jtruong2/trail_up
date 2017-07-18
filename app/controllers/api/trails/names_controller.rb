class Api::Trails::NamesController < ActionController::API
  include Sanitizer
  def index
    sanitize_query(params[:query])
    render json: Trail.where('name LIKE ?', "%#{params[:query]}%").pluck(:name)
  end
end