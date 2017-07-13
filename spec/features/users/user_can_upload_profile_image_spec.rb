require 'rails_helper'

describe "user can upload profile image" do
  scenario "user changes image from profile settings" do
    id = create(:user).id
    visit "/users/#{id}"
    expect(page).to have_link("Edit Settings")
    click("Edit Settings")
    expect(path).to eq(edit_user_path)
    expect(page).to have_link("Create Picture")

  end
end
