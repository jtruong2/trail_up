require 'rails_helper'

RSpec.describe "As an admin" do
  it "can make delete a user" do
    admin = create(:user, role: 'admin')
    user = create(:user)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    expect(User.count).to eq(2)
    visit admin_users_path
    within all('.user').last do
      click_link 'Delete'
    end
    expect(User.count).to eq(1)
  end
end