require 'rails_helper'

RSpec.describe "As a guest" do
  it "can search for an event from the landing page" do
    create(:trail, name: "Clear Creek Canyon", latitude: 39.7967637, longitude:-105.0426542)
    event_one = create(:event, trail_id: Trail.first.id)

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
    allow(Geocoder).to receive(:coordinates).and_return(nil)

    visit root_path
    click_on "Find Events Near You"
    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content("Your search returned 0 results")
  end

  it "only returns results within 30 miles by default" do
    create(:trail, name: "Clear Creek Canyon", latitude: 30.0, longitude:-100.0)
    create(:trail, name: "Mount Evans", latitude: 31.0, longitude: -101.0)
    event_one = create(:event, trail_id: Trail.first.id)
    event_two = create(:event, trail_id: Trail.last.id)
    visit root_path
    fill_in :event_search, with: "Rocksprings,TX"
    click_on "Find Events Near You"
    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content(event_one.name)
    expect(page).to_not have_content(event_two.name)
  end
end


