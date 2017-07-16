require 'rails_helper'

RSpec.describe Event, type: :model do
  before(:each) do
    @user = create(:user)

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
  it {should have_many(:event_guests)}
  it {should have_many(:guests).through(:event_guests).source(:guest)}
  it {should have_many(:event_hosts)}
  it {should have_many(:hosts).through(:event_hosts).source(:host)}

  scenario "archived attribute should default to false" do
    user = create(:user)
    trail = create(:trail)
    event = Event.create!(name: "Epic event", description: "This will be so epic", date: "07-07-2017 18:57:17", trail_id: trail.id )
    expect(event.archived).to eq(false)
  end
end
