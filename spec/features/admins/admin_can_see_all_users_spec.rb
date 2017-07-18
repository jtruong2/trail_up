require 'rails_helper'

RSpec.describe "As an admin" do
  it "can see all users and actions" do
  admin = create(:user, role: 'admin')
  users = create_list(:user, 5)
  user = users.first
  
  allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

  visit admin_users_path
  expect(page).to have_selector('.user', count: 6)
  expect(page).to have_selector('.admin_button', count: 5)
  expect(page).to have_content(user.username)
  expect(page).to have_content(user.email)
  expect(page).to have_content('Delete')
  end
end