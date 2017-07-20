require "rails_helper"

RSpec.describe "As an admin" do
  it "logs in and is taken to admin dashboard" do
    user = create(:user, role: "admin")
    visit root_path
    click_link "Login"
    fill_in :session_email, with: user.email
    fill_in :session_password, with: "password"
    click_on 'Submit'
    click_link "Dashboard"
    
    expect(current_path).to eq(admin_dashboard_index_path)
    expect(page).to have_content("All Users")
    expect(page).to have_content("All Events")
    expect(page).to have_content("All Trails")
  end
end