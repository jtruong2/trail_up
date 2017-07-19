require 'rails_helper'
require 'date'

describe "events auto archive after 2 days" do
  scenario "event auto archives" do
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
                              date: DateTime.new(2017, 7, 2),
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
    @event_2 = Event.create!(trail_id: @trail_1.id,
                              name: "The big oness",
                              description: "It's a big onesss",
                              date: DateTime.new(2017, 7, 1),
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
    visit root_path
    event_1 = Event.find(@event_1.id)
    event_2 = Event.find(@event_2.id)
    # expect(event_1.archived).to eq(true)
    # expect(event_2.archived).to eq(true)
  end
end
