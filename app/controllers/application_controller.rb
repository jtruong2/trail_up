class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_partial

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_partial
    current_user ? 'layouts/user' : 'layouts/guest'
  end

end
