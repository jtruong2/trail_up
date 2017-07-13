class Permission

  def initialize(current_user, controller, action, identifier)
    @user = current_user
    @controller = controller
    @action = action
    @identifier = identifier
  end

  def authorized?
    return true if user == nil && controller == "sessions"
    return true if user == nil && action.in?(%w(new create))
    return true if user == nil && controller == "trails" && action == "index"
    return true if user == nil && controller == "trails" && action == "index"
    return true if user == nil && controller == "trails/search"
    return true if user == nil && controller == "directions"
    return true if controller == "landing" && action == "index"
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "dashboards" && user
    if user.admin?
      admin_permissions
    elsif user
      user_permissions
    end
  end

  private

  attr_reader :user, :controller, :action, :identifier

    def user_permissions
      return true if controller == "trails" && action.in?(%w(index new create show))
      return true if controller == "users" && action == "show" && user_page_check == true
    end

    def user_page_check
      return true if user.slug == identifier || user.id == identifier
    end

end
