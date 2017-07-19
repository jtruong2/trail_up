class Permission

  def initialize(current_user, controller, action, identifier)
    @user = current_user
    @controller = controller
    @action = action
    @identifier = identifier
  end

  def authorized?
    if user && user.admin?
      admin_permissions
    elsif user
      user_permissions
    else
      guest_permissions
    end
  end

  private

  attr_reader :user, :controller, :action, :identifier

    def admin_permissions
      return true if controller == "admin/trails" && action.in?(%w(index new create show destroy))
      return true if controller == "admin/users"
      return true if controller == "admin/events" && action.in?(%w(index new create show destroy))
      return true if controller == "landing" && action == "index"
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == "dashboards" && action.in?(%w(show))
      return true if controller == "pictures" && action.in?(%w(create))
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "users" && action == "show" && user_page_check == true
      return true if controller == "trails" && action.in?(%w(index new create show))
      return true if controller == "trails/select"
      return true if controller == "trails/search"
      return true if controller == "events" && action.in?(%w(select_or_create_trail new create show status destroy))
      return true if controller == "events/search"
      return true if controller == "events/user_status"
      return true if controller == "directions"

    end

    def user_permissions
      return true if controller == "fitbit_json" && action.in?(%w(index show))
      return true if controller == "fitbit" && action.in?(%w(index login show))
      return true if controller == "events/event_status" && action.in?(%w(index))
      return true if controller == "landing" && action == "index"
      return true if controller == "sessions" && action.in?(%w(new create destroy))
      return true if controller == "dashboards" && action.in?(%w(show))
      return true if controller == "pictures" && action.in?(%w(create))
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "users" && action == "show" && user_page_check == true
      return true if controller == "trails" && action.in?(%w(index new create show edit update))
      return true if controller == "trails/select"
      return true if controller == "trails/search"
      return true if controller == "events" && action.in?(%w(select_or_create_trail new create show status destroy))
      return true if controller == "events" && action.in?(%w(edit update)) && user.event_status(identifier) == "host"
      return true if controller == "events/search"
      return true if controller == "events/user_status"
      return true if controller == "directions"
    end

    def user_page_check
      return true if user.slug == identifier || user.id == identifier.to_i
    end

    def guest_permissions
      return true if controller == "sessions" && action.in?(%w(new create))
      return true if controller == "landing" && action == "index"
      return true if controller == "users" && action.in?(%w(new create))
      return true if controller == "trails" && action.in?(%w(index show))
      return true if controller == "trails/search"
      return true if controller == "trails/select"
      return true if controller == "events" && action.in?(%w(show))
      return true if controller == "events/search"
      return true if controller == "directions"
      return false if user.nil?
    end
end
