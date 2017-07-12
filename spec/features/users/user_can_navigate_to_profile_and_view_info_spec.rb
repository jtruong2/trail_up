require "rails_helper"

describe "user can view profile information" do
  scenario "user can navigate to profile page and view basic content" do
    user = create(:user)

    visit root_path

    expect(page).to have_content("Login")
    click_on("Login")
    fill_in("Username or Email", with: user.email)
    fill_in("Password", with: user.password)
    click_on("Submit")

    expect(page).to have_content(user.username)
    click_on(user.username)
    expect(current_path).to eq("/users/#{user.id}")

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
  end
end
