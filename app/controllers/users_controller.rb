class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages
      redirect_to signup_path
    end
  end

  def show
    @user = User.find_by(slug: params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end