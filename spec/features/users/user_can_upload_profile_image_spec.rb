require 'rails_helper'

describe "user can upload profile image" do
  scenario "user changes image from profile settings" do
    id = create(:user).id
    visit "/users/#{id}"
    expect(page).to have_button("Edit Settings")
    click_on("Edit Settings")
    expect(current_path).to eq("/users/#{id}/edit")
    expect(page).to have_button("Create Picture")

  end
end
