require 'rails_helper'

describe "admin pages are protected" do
  scenario "user receives 404 error when manipulating url" do
    user_1 = create(:user)
    admin = create(:user, username: "full admin", role: 0, email: "admin@gmail.com")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit "/admin/trails"
    expect(page).to have_content('404')
    visit "/admin/users"
    expect(page).to have_content('404')
    visit "/admin/events" 
    expect(page).to have_content('404')
  end
end
