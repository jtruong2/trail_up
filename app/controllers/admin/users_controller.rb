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
    @user.hosting.destroy_all
    User.destroy(@user.id) if current_user.admin? && @user.id != current_user.id
    if @user.id == current_user.id
      flash[:error] = ["You Cannot Delete Yourself!" ]
    else
      flash[:success] = ["User Successfully Deleted"]
    end
    redirect_to admin_dashboard_index_path
  end

  private

  def set_user
    @user = User.find_by(slug: params[:id])
  end

  
end
