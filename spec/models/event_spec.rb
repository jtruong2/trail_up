require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:trail) do
    Trail.create(name: "Awesome Trail",
                 description: "This Trail is Amazing!",
                 difficulty: "Double Black Diamond",
                 location: "Boulder, CO",
                 distance: 22.5,
                 rating: 5.0,
                 long: 30.000,
                 lat: -100.000)
  end

  let(:host) do
    User.create(username: "Host Name", email: "example@gmail.com", password: "password")
  end

  it "has name, description, date, trail, and host attributes" do
    event = Event.create(trail_id: trail.id,
                         user_id: host.id,
                         name: "Event Name",
                         description: "Event Description",
                         date: "2017-07-12 18:57:17")
    expect(event).to be_valid
  end

  it "must belong to a trail" do
    no_trail_event = Event.create(user_id: host.id,
                                  name: "Event Name",
                                  description: "Event Description",
                                  date: "2017-07-12 18:57:17")
    expect(no_trail_event).not_to be_valid
  end

  it "must belong to a host" do
    no_host_event = Event.create(trail_id: trail.id,
                                 name: "Event Name",
                                 description: "Event Description",
                                 date: "2017-07-12 18:57:17")
    expect(no_host_event).not_to be_valid
  end

  it "must have a name" do
    no_name_event = Event.create(trail_id: trail.id,
                                 user_id: host.id,
                                 description: "Event Description",
                                 date: "2017-07-12 18:57:17")
    expect(no_name_event).not_to be_valid
  end

  it "must have a description" do
    no_description_event = Event.create(trail_id: trail.id,
                                        user_id: host.id,
                                        name: "Event Name",
                                        date: "2017-07-12 18:57:17")
    expect(no_description_event).not_to be_valid
  end

  it "must have a date" do
    no_date_event = Event.create(trail_id: trail.id,
                                 user_id: host.id,
                                 name: "Event Name",
                                 description: "Event Description")
    expect(no_date_event).not_to be_valid
  end
end
