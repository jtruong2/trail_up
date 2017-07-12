require 'rails_helper'

RSpec.describe "User can create trail" do
  it 'can manually fill in information to create trail'
    user = create(:user)
    trail = build(:trail)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and response_with(user)
    
    visit new_trail_path

    fill_in "Name", with: trail.name
    fill_in "Description", with: trail.description
    fill_in "Difficulty", with: trail.difficulty
    fill_in "Location", with: trail.location
    fill_in "Distance", with: trail.distance

    click_on "Create New Trail"

    expect(current_path).to eq(trail_path(Trail.first))
    expect(page).to have_content(trail.name)
    expect(page).to have_content(trail.descriptions)
    expect(page).to have_content(trail.difficulty)
    expect(page).to have_content(trail.location)
    expect(page).to have_content(trail.distance)
  end
end
