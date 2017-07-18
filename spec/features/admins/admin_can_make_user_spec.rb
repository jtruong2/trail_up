require 'rails_helper'

RSpec.describe "As an admin" do
  it "can make user an admin" do
    admin = create(:user, role: 'admin')
    user = create(:user)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit admin_users_path
    expect(user.role).to be_nil
    click_link "Make Admin"
    expect(User.last).to be_admin
  end
end