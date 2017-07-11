class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error in your login credentials."
      redirect_to signup_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end
