require 'rails_helper'

RSpec.describe "User creates an event" do
  scenario "user creates an event from a new trail" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/"
    click_on "Create Event"
    expect(current_path).to eq(trails_select_index_path)
    expect(page).to have_content("Create a New Trail")
    click_on "Create a New Trail"
    expect(current_path).to eq(new_trail_path)

    fill_in "Name", with: "Totally Epic Trail"
    fill_in "Description", with: "This Trail is SOOO Epic"
    select "Double Black Diamond", from: "trail[difficulty]"
    fill_in "Location", with: "Boulder, Colorado"
    fill_in "Distance", with: 30.0
    click_on "Create New Trail"

    expect(current_path).to eq(new_event_path)
    # I should be able to see my trail selection on a map (not yet implemented)
    expect(page).to have_content("Epic Trail")
    expect(page).to have_content("This Trail is SOOO Epic")
    expect(page).to have_content("Double Black Diamond")
    expect(page).to have_content("Boulder, Colorado")
    expect(page).to have_content("30.0")

    fill_in "Event Name", with: "Halloween Epic Trail Hike"
    fill_in "Event Description", with: "A spooky hike on an epic trail!"
    select 2017, from: "event[date(1i)]"
    select "October", from: "event[date(2i)]"
    select 31, from: "event[date(3i)]"
    select 23, from: "event[date(4i)]"
    select 59, from: "event[date(5i)]"
    click_on "Publish Event"

    expect(current_path).to eq(event_path(Event.first))
    expect(page).to have_content("Hosted by: #{user.username}")
    expect(page).to have_content("Halloween Epic Trail Hike")
    expect(page).to have_content("A spooky hike on an epic trail!")
    expect(page).to have_content("2017-10-31 23:59:00")

    expect(page).to have_content("Epic Trail")
    expect(page).to have_content("This Trail is SOOO Epic")
    expect(page).to have_content("Double Black Diamond")
    expect(page).to have_content("Boulder, Colorado")
    expect(page).to have_content("30.0")
  end
  scenario "user creates an event from an existing trail" do
    # user = create(:user)
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    # visit "/"
    # click_on "Create Event"
    # expect(current_path).to eq(select_or_create_trail_path)
    # expect(page).to have_content("Create a New Trail")
    # click_on "Create a New Trail"
    # expect(current_path).to eq(new_trail_path)

    # fill_in "Name", with: "Totally Epic Trail"
    # fill_in "Description", with: "This Trail is SOOO Epic"
    # select "Double Black Diamond", from: "trail[difficulty]"
    # fill_in "Location", with: "Boulder, Colorado"
    # fill_in "Distance", with: 30.0
    # click_on "Create New Trail"

    # expect(current_path).to eq(new_event_path)
    # # I should be able to see my trail selection on a map (not yet implemented)
    # expect(page).to have_content("Epic Trail")
    # expect(page).to have_content("This Trail is SOOO Epic")
    # expect(page).to have_content("Double Black Diamond")
    # expect(page).to have_content("Boulder, Colorado")
    # expect(page).to have_content("30.0")

    # fill_in "Event Name", with: "Halloween Epic Trail Hike"
    # fill_in "Event Description", with: "A spooky hike on an epic trail!"
    # select 2017, from: "event[date(1i)]"
    # select "October", from: "event[date(2i)]"
    # select 31, from: "event[date(3i)]"
    # select 23, from: "event[date(4i)]"
    # select 59, from: "event[date(5i)]"
    # click_on "Publish Event"

    # expect(current_path).to eq(event_path(Event.first))
    # expect(page).to have_content("Hosted by: #{user.username}")
    # expect(page).to have_content("Halloween Epic Trail Hike")
    # expect(page).to have_content("A spooky hike on an epic trail!")
    # expect(page).to have_content("2017-10-31 23:59:00")

    # expect(page).to have_content("Epic Trail")
    # expect(page).to have_content("This Trail is SOOO Epic")
    # expect(page).to have_content("Double Black Diamond")
    # expect(page).to have_content("Boulder, Colorado")
    # expect(page).to have_content("30.0")
  end
end
