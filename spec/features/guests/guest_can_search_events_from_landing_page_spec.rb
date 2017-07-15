require 'rails_helper'

RSpec.describe "As a guest" do
  it "can search for an event from the landing page" do

    event_one = create(:event)

    visit root_path
    fill_in :event_search, with: "80210"
    click_on "Find Events Near You"
    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content("Your search returned 1 results")
    expect(page).to have_content(event_one.name)
    expect(page).to have_content(event_one.description)
    expect(page).to have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
    expect(page).to have_content(event_one.trail.name)
  end

  it "can search with nothing in search field" do

    visit root_path
    click_on "Find Events Near You"

    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content("Your search returned 0 results")
  end

  it "returns results within 30 miles" do

    create(:trail, name: "Clear Creek Canyon", location: "Golden, CO", latitude: 39.7967637, longitude:-105.0426542)
    create(:trail, name: "Mount Evans", location: "ClearCreekCounty,CO", longitude: 39.5883005, latitude: -105.6438286)
    
    event_one = create(:event, trail_id: Trail.first.id)
    event_two = create(:event, trail_id: Trail.last.id)
    
    visit root_path
    fill_in :event_search, with: "Denver, CO"
    click_on "Find Events Near You"
    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content(event_one.name)
    expect(page).to_not have_content(event_two.name)
  end
end


