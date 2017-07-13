require 'rails_helper'

describe "user can upload profile image" do
  scenario "user changes image from profile settings" do
    user = create(:user)
    slug = user.username
    visit "/users/#{slug}"
    expect(page).to have_button("Edit Settings")
    click_on("Edit Settings")
    expect(current_path).to eq("/users/#{slug}/edit")
    expect(page).to have_button("Create Picture")

  end
end
