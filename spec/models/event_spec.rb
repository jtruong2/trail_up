require 'rails_helper'

RSpec.describe Event, type: :model do
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
