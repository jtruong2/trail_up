class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:email]) || User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = ["Invalid credentials. Please check your email and password."]
      redirect_to "/login"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

    def session_params
      params.require(:session).permit(:email)
    end
end
