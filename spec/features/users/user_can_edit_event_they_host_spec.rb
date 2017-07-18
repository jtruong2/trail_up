require 'rails_helper'

describe "user that is a host can edit their event" do
  before(:each) do
    @user_guest = create(:user, username: "guest")
    @user = create(:user, email: "user@gmail.com")
    @user_host = create(:user, username: "host", email: "host@gmail.com")

    @trail_1 = Trail.create!(name: "The Hardest One of All",
                              description: "It is really hard",
                              difficulty: "Hard as Diamonds",
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
    @event_roles = EventRole.create!(user_id: @user_guest.id, event_id: @event_1.id, role: 0)

    @trail_2 = Trail.create!(name: "The Hardest One of All2",
                              description: "It is really hard",
                              difficulty: "Hard as Diamonds",
                              location: "Boulder, CO",
                              distance: 5.5,
                              rating: 4.9,
                              longitude: 39.7392,
                              latitude: 104.9903)
    @event_2 = Event.create!(trail_id: @trail_2.id,
                              name: "The big one2",
                              description: "It's a big one",
                              date: "22/01/2017",
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
    @event_roles_2 = EventRole.create!(user_id: @user_host.id, event_id: @event_2.id, role: 1)
  end

  scenario "host can edit an event" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_host)
    visit "/events/#{@event_2.id}"

    expect(page).to have_content("Edit Event")

    click_on "Edit Event"

    expect(current_path).to eq("/events/#{@event_2.id}/edit")
    expect(page).to have_content("Edit #{@event_2.name}")
    expect(page).to have_content("Name")
    expect(page).to have_content("Description")
    expect(page).to have_content("Date")

    fill_in "event_name", with: "The Big One 3"
    fill_in "event_description", with: "It's actually not the hardest"

    click_on "Update Event"

    expect(current_path).to eq("/events/#{@event_2.id}")
    expect(page).to have_content("The Big One 3")
    expect(page).to have_content("It's actually not the hardest")

  end
end
