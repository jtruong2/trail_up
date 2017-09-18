require 'rails_helper'

describe "users can see events and decide to join or not" do
  before(:each) do
    @user_guest = create(:user, username: "guest")
    @user = create(:user, email: "email@gmail.com")
    @user_host = create(:user, username: "host", email: "host@gmail.com")
    @difficulty = create(:difficulty, rating: "Hard as Diamonds" )

    @trail_1 = Trail.create!(name: "The Hardest One of All",
                              description: "It is really hard",
                              difficulty: @difficulty,
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
                              difficulty: @difficulty,
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

  scenario "user can find events from the homepage and navigate to show page and join event" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit root_path

    fill_in "event_search", with: "Denver"
    click_on "Find Events Near You"

    expect(current_path).to eq('/events/search')
    expect(page).to have_content(@event_1.name)
    expect(page).to have_content(@event_1.description)

    first(:link, @event_1.name).click

    expect(current_path).to eq("/events/#{@event_1.id}")
    expect(page).to have_content("Join Event")
    expect(page).to_not have_content("Delete Event")

    click_on "Join Event"

    expect(current_path).to eq("/events/#{@event_1.id}")
    expect(page).to have_content("Leave Event")
  end

  scenario "authenticated user tries to join event" do
    visit "/events/#{@event_1.id}"

    expect(page).to have_content("Login to join")

    click_on "Login to join"

    expect(current_path).to eq("/login")
  end

  scenario "host sees delete event on event show page and can click it" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_host)
    visit root_path

    fill_in "event_search", with: "Boulder"
    click_on "Find Events Near You"

    expect(current_path).to eq('/events/search')
    expect(page).to have_content(@event_2.name)
    expect(page).to have_content(@event_2.description)

    click_on @event_2.name

    expect(page).to have_content("Delete Event")

    all('.role-based-event-link').first.click

    expect(current_path).to eq(root_path)
  end

  scenario "user can leave event" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_guest)
    visit "/events/#{@event_1.id}"

    expect(current_path).to eq("/events/#{@event_1.id}")

    expect(page).to have_content("Leave Event")

    click_on "Leave Event"

    expect(current_path).to eq("/events/#{@event_1.id}")
    expect(page).to have_content("Join Event")

  end
end
