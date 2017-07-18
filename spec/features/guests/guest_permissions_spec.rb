require 'rails_helper'

RSpec.describe 'Guest cannot view some pages' do

  it 'cannot view new trail path' do
    visit "/trails/new"
    expect(page).to have_content('404')
  end

  it 'cannot view edit trail path' do
    trail = create(:trail)
    visit "/trails/#{trail.id}/edit"
    expect(page).to have_content('404')
  end

  it 'cannot view dashboard' do
    visit "/dashboard"
     expect(page).to have_content('404')
  end

  it 'cannot join an event' do
    event = create(:event)
    visit("events/#{event.id}")

    expect(page).not_to have_content('Join Event')
  end
end