class Permission

  def initialize(current_user, controller, action, identifier)
    @user = current_user
    @controller = controller
    @action = action
    @identifier = identifier
  end

  def authorized?

    return true if controller == "landing" && action == "index"
    return true if controller == "sessions" && action.in?(%w(new create destroy))
    return true if controller == "trails/search" && action.in?(%w(index))

    return true if user == nil && controller == "sessions"
    return true if user == nil && controller == "users" && action.in?(%w(new create))
    return true if user == nil && controller == "trails" && action == "index"
    return true if user == nil && controller == "trails/search"
    return true if user == nil && controller == "events/search"
    return true if user == nil && controller == "directions"

    return false if user.nil?

    if user.admin?
      admin_permissions
    elsif user
      user_permissions
    end
  end

  private

  attr_reader :user, :controller, :action, :identifier

    def user_permissions
      return true if controller == "dashboards" && action.in?(%w(show))
      return true if controller == "directions" && action.in?(%w(index))
      return true if controller == "events" && action.in?(%w(select_or_create_trail new create show))
      return true if controller == "pictures" && action.in?(%w(create))
      return true if controller == "users" && action.in?(%w(edit))  
      return true if controller == "trails" && action.in?(%w(index new create show))
      return true if controller == "users" && action == "show" && user_page_check == true
      return true if controller == "trails/search"
      return true if controller == "directions"
    end

    def user_page_check
      return true if user.slug == identifier || user.id == identifier
    end

    def admin_permissions
      return true if controller == "admin/trails" && action.in?(%w(index new create show delete))
      return true if controller == "admin/users" && action.in?(%w(index new create show delete))
      return true if controller == "admin/events" && action.in?(%w(index new create show delete))
    end

end
