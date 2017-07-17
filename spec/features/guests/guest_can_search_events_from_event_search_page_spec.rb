require 'rails_helper'

RSpec.describe 'As a guest' do
  context 'can search an event from the event search page' do
    it 'by location' do
      create(:trail, name: "Clear Creek Canyon", latitude: 39.7967637, longitude:-105.0426542)
      event_one = create(:event, trail_id: Trail.first.id)
      visit new_events_search_path
      fill_in :event_search, with: "80210"
      click_on "Search Events"
      expect(current_path).to eq(events_search_index_path)
      expect(page).to have_content("Your search returned 1 results")
      expect(page).to have_content(event_one.name)
      expect(page).to have_content(event_one.description)
      expect(page).to have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
      expect(page).to have_content(event_one.trail.name)
    end
    
    it 'event name' do
      create(:trail, name: "Clear Creek Canyon", latitude: 39.7967637, longitude:-105.0426542)
      event_one = create(:event, trail_id: Trail.first.id)
      visit new_events_search_path
      select "Event Name", from: :search_by
      fill_in :event_search, with: event_one.name
      click_on "Search Events"
      expect(current_path).to eq(events_search_index_path)
      expect(page).to have_content("Your search returned 1 results")
      expect(page).to have_content(event_one.name)
      expect(page).to have_content(event_one.description)
      expect(page).to have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
      expect(page).to have_content(event_one.trail.name)
    end
    
    it 'by trail name' do
      create(:trail, name: "Clear Creek Canyon", latitude: 39.7967637, longitude:-105.0426542)
      event_one = create(:event, trail_id: Trail.first.id)
      visit new_events_search_path
      select "Trail", from: :search_by
      fill_in :event_search, with: Trail.first.name
      click_on "Search Events"
      expect(current_path).to eq(events_search_index_path)
      expect(page).to have_content("Your search returned 1 results")
      expect(page).to have_content(event_one.name)
      expect(page).to have_content(event_one.description)
      expect(page).to have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
      expect(page).to have_content(event_one.trail.name)
    end
    it 'returns no results with no query' do
      create(:trail, name: "Clear Creek Canyon", latitude: 39.7967637, longitude:-105.0426542)
      event_one = create(:event, trail_id: Trail.first.id)
      visit new_events_search_path
      click_on "Search Events"
      expect(current_path).to eq(events_search_index_path)
      expect(page).to have_content("Your search returned 0 results")
      expect(page).to_not have_content(event_one.name)
      expect(page).to_not have_content(event_one.description)
      expect(page).to_not have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
      expect(page).to_not have_content(event_one.trail.name)
    end
  end
end
