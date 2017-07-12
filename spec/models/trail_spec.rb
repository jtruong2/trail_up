require 'rails_helper'

RSpec.describe Trail, type: :model do
  it "has name, description, difficulty, location, distance, rating, long, and lat attributes" do
    trail = Trail.create(name: "Awesome Trail",
                         description: "This Trail is Amazing!",
                         difficulty: "Double Black Diamond",
                         location: "Boulder, CO",
                         distance: 22.5,
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).to be_valid
  end

  it "must have a name attribute" do
    trail = Trail.create(description: "This Trail is Amazing!",
                         difficulty: "Double Black Diamond",
                         location: "Boulder, CO",
                         distance: 22.5,
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end

  it "must have a name attribute that is unique" do
    valid_trail = Trail.create(name: "Awesome Trail",
                               description: "This Trail is Amazing!",
                               difficulty: "Double Black Diamond",
                               location: "Boulder, CO",
                               distance: 22.5,
                               rating: 5.0,
                               long: 30.000,
                               lat: -100.000)
    duplicate_name_trail = Trail.create(name: "Awesome Trail",
                                        description: "This Trail is also Amazing!",
                                        difficulty: "Black Diamond",
                                        location: "Evergreen, CO",
                                        distance: 10.0,
                                        rating: 4.9,
                                        long: 30.001,
                                        lat: -100.001)
    expect(duplicate_name_trail).not_to be_valid
  end

  it "must have a description attribute" do
    trail = Trail.create(name: "Awesome Trail",
                         difficulty: "Double Black Diamond",
                         location: "Boulder, CO",
                         distance: 22.5,
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end

  it "must have a distance attribute" do
    trail = Trail.create(name: "Awesome Trail",
                         description: "This Trail is Amazing!",
                         difficulty: "Double Black Diamond",
                         location: "Boulder, CO",
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end

  it "must have a difficulty attribute" do
    trail = Trail.create(name: "Awesome Trail",
                         description: "This Trail is Amazing!",
                         location: "Boulder, CO",
                         distance: 22.5,
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end

  it "must have a location attribute" do
    trail = Trail.create(name: "Awesome Trail",
                         description: "This Trail is Amazing!",
                         difficulty: "Double Black Diamond",
                         distance: 22.5,
                         rating: 5.0,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end

  it "must have a rating attribute" do
    trail = Trail.create(name: "Awesome Trail",
                         description: "This Trail is Amazing!",
                         difficulty: "Double Black Diamond",
                         location: "Boulder, CO",
                         distance: 22.5,
                         long: 30.000,
                         lat: -100.000)
    expect(trail).not_to be_valid
  end
end
