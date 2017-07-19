require 'rails_helper'
require 'date'

describe "events auto archive after 2 days" do
  scenario "event auto archives" do
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
                              date: DateTime.new(2017, 7, 15),
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
    expect(@event_1.archived).to eq(true)
  end
end
