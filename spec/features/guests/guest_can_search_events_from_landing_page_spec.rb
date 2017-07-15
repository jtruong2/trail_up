require 'rails_helper'

RSpec.describe "As a guest" do
  it "can search fro an event from the landing page" do

    event_one = create(:event)

    visit root_path
    fill_in :event_search, with: "80210"
    click_on "Find Events Near You"
    expect(current_path).to eq(events_search_index_path)
    expect(page).to have_content(event_one.name)
    expect(page).to have_content(event_one.description)
    expect(page).to have_content(event_one.date.strftime("%A %B %e %Y at %l:%M"))
    expect(page).to have_content(event_one.trail.name)
  end

end


