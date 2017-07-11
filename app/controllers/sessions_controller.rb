class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(session_params)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error in your login credentials."
      redirect_to "/login"
    end
  end

  private

    def session_params
      params.require(:session).permit(:email, :password_digest)
    end
end
