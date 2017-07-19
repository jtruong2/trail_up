class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :current_guest
  before_action :authorize!

  def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_guest
    current_user ? 'user' : 'guest'
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def check_database_archives
    date_bot = DateChecker.new
    date_bot.check?
  end


  private

    def authorize!
      permission = Permission.new(current_user, params[:controller], params[:action], params[:id])
      render :file => 'public/404.html' unless permission.authorized?
    end

end
