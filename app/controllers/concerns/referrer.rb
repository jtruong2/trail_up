module Referrer
  extend ActiveSupport::Concern

  def request_referrer
      Rails.application.routes.recognize_path(request.referrer)[:controller]
  end

  def select_redirect(referrer, trail)
    if referrer == "trails/select"
      new_event_path(trail_id: trail.id)
    else
      trail_path(trail)
    end
  end

  
end

