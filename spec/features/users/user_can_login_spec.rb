require "rails_helper"

describe "existing user can login" do
  scenario "existing user can navigate to login page and login" do
    user = create(:user)

    visit root_path

    expect(page). to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: user.email)
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_current_path(root_path)
  end

  scenario "existing user can login with email or username" do
    user = create(:user)

    visit root_path

    expect(page). to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: user.username)
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_current_path(root_path)
  end

  scenario "existing user is redirected if they provide the wrong password" do
    user = create(:user)

    visit root_path

    expect(page). to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: user.email)
    fill_in("Password", with: "wrong password")
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_content("Invalid credentials. Please check your email and password.")
    expect(page).to have_current_path("/login")
  end

  scenario "existing user is redirected if they provide the wrong email" do
    user = create(:user)

    visit root_path

    expect(page). to have_content("Login")
    click_on("Login")
    expect(current_path).to eq("/login")
    fill_in("Username or Email", with: "wrong_email@gmail.com")
    fill_in("Password", with: user.password)
    expect(page).to have_button("Submit")
    click_on("Submit")
    expect(page).to have_content("Invalid credentials. Please check your email and password.")
    expect(page).to have_current_path("/login")
  end
end
