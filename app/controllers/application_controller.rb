class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_partial
  before_action :authorize!

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_partial
    current_user ? 'layouts/user' : 'layouts/guest'
  end

  private

    def authorize!
      permission = Permission.new(current_user, params[:controller], params[:action], params[:id])
      raise ActionController::RoutingError.new('404 Error. The page you are looking for does not exist.') unless permission.authorized?
    end

end
