require "rails_helper"

RSpec.describe "As an admin" do
  it "logs in and is taken to admin dashboard" do
    user = create(:user, role: "admin")

    visit login_path
    fill_in :session_email, with: user.email
    fill_in :session_password, with: "password"
    click_on 'Submit'

    expect(current_path).to eq(admin_dashboard_index_path)
    expect(page).to have_link("All Users")
    expect(page).to have_link("All Events")
    expect(page).to have_link("All Trails")
  end
end