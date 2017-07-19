class MeetupSessionsController < ApplicationController
  def create
    binding.pry
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    binding.pry
    session[:user_id] = user.id
    redirect_to dashboard_path(user)
  end
end