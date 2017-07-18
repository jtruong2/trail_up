require 'rails_helper'

describe "full admin has namespace access" do
  scenario "admin can visit basic admin pages " do
    admin = create(:user, username: "full admin", role: 0, email: "admin@gmail.com")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/trails"
    expect(current_path).to eq("/admin/trails")
    visit "/admin/users"
    expect(current_path).to eq("/admin/users")
    # visit "/admin/users/full-admin"
    # expect(current_path).to eq("/admin/users/full-admin")
    visit "/admin/events"
    expect(current_path).to eq("/admin/events")
  end
end
