require "rails_helper"

describe " user can login and see updated navbar " do
  scenario " user sees correct navbar " do
    user = create(:user)

    visit root_path

    expect(page).to have_content("Login")
    expect(page).to have_content("SignUp")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: user.email)
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_current_path("/dashboard")

    expect(page).to_not have_content("Login")
    expect(page).to_not have_content("SignUp")
    expect(page).to have_content("Logout")
  end
end
