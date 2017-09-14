class GoogleSessionsController < ApplicationController
  def create
    byebug
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end
end
