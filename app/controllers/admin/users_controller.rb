class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def update
    @user = User.find_by(slug: params[:id])
    if current_user.admin?
      @user.update_attribute(:role, "admin")
      @user.save
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find_by(slug: params[:id])
    User.destroy(@user.id) if current_user.admin?
    redirect_to admin_users_path
  end
  
end
