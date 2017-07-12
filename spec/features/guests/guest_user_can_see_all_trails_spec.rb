require 'rails_helper'

RSpec.describe "Guest visits trails index page" do
  context "with no explicit search zipcode search" do
    it "displays 10 results at time based on default location" do
      allow(HikingProjectService).to receive(:search).and_return(trail_index_stub)
      visit trails_path
      
      expect(page).to have_content("Round the block summit pass hyperloop ft connector")
      expect(page).to have_content("Difficulty: Blue")
      expect(page).to have_content("Length: 0.5 miles")
      expect(page).to_not have_content("Mount Falcon East Loop")
      expect(page).to have_selector('.trail', count: 10)

      click_link "2"

      expect(page).to have_content("Mount Falcon East Loop")
      expect(page).to_not have_content("Round the block summit pass hyperloop ft connector")
      expect(page).to have_selector('.trail', count: 10)
        
    end
  end
end
