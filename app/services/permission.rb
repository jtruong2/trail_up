class Permission

  def initialize(current_user, controller, action, identifier)
    @user = current_user
    @controller = controller
    @action = action
    @identifier = identifier
  end

  def authorized?
    return true if controller == "landing_controller" && action == "index"
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "dashboard_controller" && user

    if user.admin?
      admin_permissions
    else
      user_permissions
    end
  end

  private

  attr_reader :user, :controller, :action, :identifier

    def user_page_check
      binding.pry
    end

    def user_permissions
      return true if controller == "trails_controller" && action.in?(%w(index new create show))
      if
    end


end
