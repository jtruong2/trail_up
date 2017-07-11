require 'rails_helper'

RSpec.describe "Guest registers a new account" do
  scenario "guest can navigate to sign-up page and fill in the form" do
    visit root_path
    expect(page).to have_content("SIGNUP")
    click_on("SIGNUP")
    expect(page).to have_current_path("/signup")
    expect(page).to have_content("Username")
    fill_in("Username", with: "Example User Name")
    expect(page).to have_content("Email")
    fill_in("Email", with: "example@gmail.com")
    expect(page).to have_content("Password")
    fill_in("Password", with: "password")
    expect(page).to have_button("Signup")
    expect(page).to have_current_path("/dashboard")
  end

  scenario "guest tries to create an account without a password" do
    visit root_path
    expect(page).to have_content("SIGNUP")
    click_on("SIGNUP")
    expect(page).to have_current_path("/signup")
    expect(page).to have_content("Username")
    fill_in("Username", with: "Example User Name")
    expect(page).to have_content("Email")
    fill_in("Email", with: "example@gmail.com")
    expect(page).to have_content("Password")
    expect(page).to have_button("Signup")
    expect(page).to have_content("error")
    expect(page).to have_current_path("/signup")
  end
end
