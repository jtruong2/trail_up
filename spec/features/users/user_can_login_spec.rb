require "rails_helper"

describe "existing user can login" do
  scenario "existing user can navigate to login page and login" do
    user = create(:user)

    visit root_path

    expect(page). to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_current_path("/dashboard")
  end
end
