class SessionsController < ApplicationController

  def new
    session[:return_path] = request.referrer
  end

  def create
    user = User.find_by(username: user_params[:email]) || User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to session[:return_path]
      session.delete(:return_path)
    else
      flash[:error] = ["Invalid credentials. Please check your email and password."]
      redirect_to "/login"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def user_params
    params.require(:session).permit(:email, :password)
  end

end
