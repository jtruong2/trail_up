require 'rails_helper'

RSpec.describe "User can create trail" do
  it 'can manually fill in information to create trail' do
    user = create(:user)
    trail = build(:trail)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit new_trail_path
    fill_in "Name", with: trail.name
    fill_in "Description", with: trail.description
    select "Double Black Diamond", from: "trail[difficulty]"
    fill_in "Location", with: trail.location
    fill_in "Distance", with: trail.distance

    click_on "Create New Trail"

    expect(current_path).to eq(trail_path(Trail.first))
    expect(page).to have_content(trail.name)
    expect(page).to have_content(trail.description)
    expect(page).to have_content(trail.difficulty)
    expect(page).to have_content(trail.location)
    expect(page).to have_content(trail.distance)
  end
end
