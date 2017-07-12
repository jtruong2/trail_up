require "rails_helper"

describe "user can logout" do
  scenario "user can logout" do
    user = create(:user)

    visit root_path

    expect(page).to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: user.email)
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_current_path("/dashboard")

    click_on("Logout")
    expect(page).to have_current_path(root_path)
    expect(page).to_not have_content("Logout")
    
    expect(page).to have_content("SignUp")
    expect(page).to have_content("Login")

  end
end
