class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:update, :destroy]

  def index
    @users = User.all
  end

  def update
    @user.update_attribute(:role, "admin") if current_user.admin?
    redirect_to admin_users_path
  end

  def destroy
    User.destroy(@user.id) if current_user.admin?
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  
end
