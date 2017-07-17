require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    @user = create(:user, username: "TomTom", email: "tomtom@gmail.com")

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

  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:description)}
  it {should validate_presence_of(:date)}
  it {should belong_to(:trail)}
  it {should have_many(:event_roles)}
  it {should have_many(:users).through(:event_roles)}

  scenario "archived attribute should default to false" do
    user = create(:user)
    trail = create(:trail)
    event = Event.create!(name: "Epic event", description: "This will be so epic", date: "07-07-2017 18:57:17", trail_id: trail.id )
    expect(event.archived).to eq(false)
  end

  scenario "User.hosts returns all events that the user has and is hosting" do
    expect(@user.hosting.count).to eq(4)
    expect(@user.hosting.first).to be_an Event
  end

  scenario "User.attending returns all events that the user has and is attending" do
    expect(@user.attending.count).to eq(4)
    expect(@user.attending.first).to be_an Event
  end

  scenario "current_user.events returns all events that the user is either hosting or attending" do
    expect(@user.events.count).to eq(8)
    expect(@user.events.first).to be_an Event
  end
end
