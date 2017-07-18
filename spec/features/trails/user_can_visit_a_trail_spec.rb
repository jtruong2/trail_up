require 'rails_helper'

RSpec.describe 'User can visit a trail show page' do

  it 'can see a trail made by a user' do

    trail = create(:trail)

    visit("trails/#{trail.id}")

    expect(page).to have_content(trail.name)
    expect(page).to have_content(trail.description)
    expect(page).to have_content(trail.difficulty)
    expect(page).to have_content(trail.distance)
    expect(page).to have_content(trail.location)
  end
end