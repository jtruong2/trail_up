require 'rails_helper'

describe "user can upload profile image" do
  scenario "user changes image from profile settings" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    slug = user.username
    visit "/users/#{user.slug}"
    expect(page).to have_button("Edit Settings")
    click_on("Edit Settings")
    expect(current_path).to eq("/users/#{user.slug}/edit")
    expect(page).to have_button("Create Picture")

  end
end
