require 'rails_helper'

describe "admin pages are protected" do
  scenario "user receives 404 error when manipulating url" do
    user_1 = create(:user)
    admin = create(:user, username: "full admin", role: 0, email: "admin@gmail.com")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit "/admin/trails"
    expect{ visit "/admin/trails" }.to raise_error(ActionController::RoutingError)
    expect{ visit "/admin/users" }.to raise_error(ActionController::RoutingError)
    expect{ visit "/admin/users/full-admin" }.to raise_error(ActionController::RoutingError)
    expect{ visit "/admin/events" }.to raise_error(ActionController::RoutingError)
  end
end
