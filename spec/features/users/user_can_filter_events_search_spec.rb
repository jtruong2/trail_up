require 'rails_helper'

describe "Filtering events" do
  before(:each) do
    @user = create(:user)
    @other_user = create(:user, username: "not current user", email: "notuser@gmail.com")

    @edge_case_event = create(:event)
    @edge_case_role_table= EventRole.create!(event_id: @edge_case_event.id, user_id: @other_user.id)

    @event_past_hosting_1 = create(:event, archived: true)
    @event_past_hosting_2 = create(:event, archived: true)
    @event_host_1 = EventRole.create(event_id: @event_past_hosting_1.id, user_id: @user.id, role: 1)
    @event_host_2 = EventRole.create(event_id: @event_past_hosting_2.id, user_id: @user.id, role: 1)

    @event_past_attending_1 = create(:event, archived: true)
    @event_past_attending_2 = create(:event, archived: true)
    @event_host_1 = EventRole.create(event_id: @event_past_attending_1.id, user_id: @user.id, role: 0)
    @event_host_2 = EventRole.create(event_id: @event_past_attending_2.id, user_id: @user.id, role: 0)

    @event_future_hosting_1 = create(:event, archived: false)
    @event_future_hosting_2 = create(:event, archived: false)
    @event_host_1 = EventRole.create(event_id: @event_future_hosting_1.id, user_id: @user.id, role: 1)
    @event_host_2 = EventRole.create(event_id: @event_future_hosting_2.id, user_id: @user.id, role: 1)

    @event_future_attending_1 = create(:event, archived: false)
    @event_future_attending_2 = create(:event, archived: false)
    @event_host_1 = EventRole.create(event_id: @event_future_attending_1.id, user_id: @user.id, role: 0)
    @event_host_2 = EventRole.create(event_id: @event_future_attending_2.id, user_id: @user.id, role: 0)
  end

  scenario "user can visit dashboard" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    expect(page).to have_content("Dashboard")
    click_on("Dashboard")

    expect(current_path).to eq('/dashboard')
  end

  scenario "user sees upcoming events by default" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    expect(page).to have_content(@user.username)
    expect(page).to have_content("Upcoming")

    expect(page).to have_content(@event_future_hosting_1.name)
    expect(page).to have_content(@event_future_hosting_2.name)
    expect(page).to have_content(@event_future_attending_1.name)
    expect(page).to have_content(@event_future_attending_2.name)

    expect(page).to_not have_content(@edge_case_event.name)
  end
end
