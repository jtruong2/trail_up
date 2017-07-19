require 'rails_helper'
require 'date'

describe "events auto archive two days after date of event" do
  scenario "event auto archives" do
    difficulty = Difficulty.create!(rating: 5)
    @trail_1 = Trail.create!(name: "The Hardest One of All",
                              description: "It is really hard",
                              difficulty_id: difficulty.id,
                              location: "Denver, CO",
                              distance: 5.5,
                              rating: 4.9,
                              longitude: 39.7392,
                              latitude: 104.9903)
    @event_1 = Event.create!(trail_id: @trail_1.id,
                              name: "The big one",
                              description: "It's a big one",
                              date: Date.today.to_time.noon,
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
                              
    expect(Event.first.archived).to eq(false)
    
    EventArchiveWorker.new.perform
  Timecop.travel(Date.tomorrow.to_time.noon)
    expect(Event.first.archived).to eq(false)
    
    Timecop.travel(Date.tomorrow.to_time.noon)
    EventArchiveWorker.new.perform
    expect(Event.first.archived).to eq(true)
  end
end
