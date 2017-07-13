require 'rails_helper'

RSpec.describe "User creates an event" do
  scenario "user creates an event from a new trail" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"
    click_on "Create Event"
    expect(page).to have_content("Create a New Trail")
    click_on "Create a New Trail"
    expect(current_path).to eq(new_trail_path)

    fill_in "Name", with: "Epic Trail"
    fill_in "Description", with: "This Trail is SOOO Epic"
    select "Double Black Diamond", from: "trail[difficulty]"
    fill_in "Location", with: "Boulder, Colorado"
    fill_in "Distance", with: 30.0
    fill_in "Rating", with: 5.0
    click_on "Create New Trail"

    expect(current_path).to eq(new_event_path)
    # I should be able to see my trail selection on a map (not yet implemented)
    expect(page).to have_content("Epic Trail")
    expect(page).to have_content("This Trail is SOOO Epic")
    expect(page).to have_content("Double Black Diamond")
    expect(page).to have_content("Boulder, Colorado")
    expect(page).to have_content("30.0")
    expect(page).to have_content("5.0")

    fill_in "Event Name", with: "Sunday Epic Trail Hike"
    fill_in "Event Description", with: "An epic hike on an epic trail!"
    select DateTime.now.tomorrow.to_date, from: "event[date]"
    fill_in "Time", with: "11:00"
    click_on "Publish Event"

    expect(current_path).to eq(event_path(Event.first))
    expect(page).to have_content("Hosted by #{user.name}")
    expect(page).to have_content("Sunday Epic Trail Hike")
    expect(page).to have_content("An epic hike on an epic trail!")
    expect(page).to have_content(DateTime.now.tomorrow.to_date)
    expect(page).to have_content("11:00")

    expect(page).to have_content("Epic Trail")
    expect(page).to have_content("This Trail is SOOO Epic")
    expect(page).to have_content("Double Black Diamond")
    expect(page).to have_content("Boulder, Colorado")
    expect(page).to have_content("30.0")
    expect(page).to have_content("5.0")
  end
end
