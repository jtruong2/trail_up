require 'rails_helper'

RSpec.describe "As a guest" do
  it "can visit homepage" do
    visit '/'
    expect(current_path).to eq(root_path)
    expect(page).to have_content("TrailUp")
    expect(page).to have_content("Find Trails. Find Friends. Get Outside")
    expect(page).to have_css('.search-box')
    expect(page).to_not have_content('Create Event')
    expect(page).to have_button("Find Events Near You")
  end
end
