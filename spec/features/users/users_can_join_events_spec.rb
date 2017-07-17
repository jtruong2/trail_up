require 'rails_helper'

describe "users can see events and decide to join or not" do
  before(:each) do
    @user = create(:user)

    @trail_1 = Trail.create!(name: "The Hardest One of All",
                              description: "It was really hard",
                              difficulty: "Hard as Diamonds",
                              location: "Denver",
                              distance: 5.5,
                              rating: 4.9,
                              longitude: 1231123,
                              latitude: 23234232)
    @event_1 = Event.create!(trail_id: @trail_1.id,
                              name: "The big one",
                              description: "It's a big one",
                              date: "22/01/2017",
                              longitude: @trail_1.longitude,
                              latitude: @trail_1.latitude
                              )
  end
end
