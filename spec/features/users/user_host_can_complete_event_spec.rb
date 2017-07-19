require 'rails_helper'

describe "host can complete an event" do
  before(:each) do
    @user_host = create(:user, username: "host", email: "host@gmail.com")
    @difficulty = Difficulty.create!(rating: 5)
    @trail_1 = Trail.create!(name: "The Hardest One of All",
                              description: "It is really hard",
                              difficulty_id: @difficulty.id,
                              location: "Denver, CO",
                              distance: 5.5,
                              rating: 4.9,
                              longitude: 39.7392,
                              latitude: 104.9903)
    @event_1 = Event.create!(trail_id: @trail_1.id,
                              name: "The big one",
                              description: "It's a big one",
                              date: "22/01/2017",
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
    @event_roles = EventRole.create!(user_id: @user_host.id, event_id: @event_1.id, role: 1)
  end

  scenario "host can complete an event" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_host)

    visit "/events/#{@event_1.id}"

    expect(page).to have_content("Mark As Complete")
    click_on "Mark As Complete"

    expect(page).to have_content "Welcome #{@user_host.username}"
  end
end
