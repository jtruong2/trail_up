class UsersController < ApplicationController

  def show
  end

  def new
    @user = User.new
    @user.build_picture
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

  def edit
  end

  def update
    if current_user.picture.update(pic_params[:image])
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password )
    end

    def pic_params
      params.require(:user).permit(image: [ :imageable_id, :imageable_type, :image ] )
    end
end
