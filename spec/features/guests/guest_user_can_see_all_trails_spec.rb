require 'rails_helper'

RSpec.describe "Guest visits trails index page" do
  xcontext "with no explicit search zipcode search" do
    it "displays 10 results at time based on default location" do
      allow_any_instance_of(HikingProjectService).to receive(:search).and_return(open_fixture('spec/support/fixtures/hiking_project_trails.json'))
      visit trails_path

      expect(page).to have_content("Bear Peak")
      expect(page).to have_content("Difficulty: Blue-black")
      expect(page).to have_content("Length: 5.7 miles")
      expect(page).to_not have_content("Mount Falcon East Loop")
      expect(page).to have_selector('.trail', count: 10)

      click_link "2"

      expect(page).to have_content("Mount Falcon East Loop")
      expect(page).to_not have_content("Bear Peak")
      expect(page).to have_selector('.trail', count: 10)

    end
  end
end
