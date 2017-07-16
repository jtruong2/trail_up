require 'rails_helper'

describe "Filtering events" do
  before(:each) do
    @user_host = create(:user, username: "Host", email: "host@gmail.com")
    @user_guest = create(:user, username: "Guest", email: "guest@gmail.com")

    @event_past_hosting_1 = create(:event, archived: true)
    @event_past_hosting_2 = create(:event, archived: true)
    @event_host_1 = EventHost.create(event_id: event_past_hosting_1.id, host_id: user_host.id)
    @event_host_2 = EventHost.create(event_id: event_past_hosting_2.id, host_id: user_host.id)

    @event_past_attending_1 = create(:event, archived: true)
    @event_past_attending_2 = create(:event, archived: true)
    @event_host_1 = EventGuest.create(event_id: event_past_attending_1.id, guest_id: user_guest.id)
    @event_host_2 = EventGuest.create(event_id: event_past_attending_2.id, guest_id: user_guest.id)

    @event_future_hosting_1 = create(:event, archived: false)
    @event_future_hosting_2 = create(:event, archived: false)
    @event_host_1 = EventHost.create(event_id: event_future_hosting_1.id, host_id: user_host.id)
    @event_host_2 = EventHost.create(event_id: event_future_hosting_2.id, host_id: user_host.id)

    @event_future_attending_1 = create(:event, archived: false)
    @event_future_attending_2 = create(:event, archived: false)
    @event_host_1 = EventGuest.create(event_id: event_future_attending_1.id, guest_id: user_guest.id)
    @event_host_2 = EventGuest.create(event_id: event_future_attending_2.id, guest_id: user_guest.id)
  end
end
