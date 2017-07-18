require 'rails_helper'

describe "users can see events and decide to join or not" do
  before(:each) do
    @user = create(:user)

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
  end

  scenario "user can find events from the homepage and navigate to show page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    fill_in "event_search", with: "Denver"
    click_on "Find Events Near You"

    expect(current_path).to eq('/events/search')
    expect(page).to have_content(@event_1.name)
    expect(page).to have_content(@event_1.description)

    click_on @event_1.name
    expect(current_path).to eq("/events/#{@event_1.id}")
    expect(page).to have_content("Join Event")
  end
end
