require 'rails_helper'
  
RSpec.describe "As a user" do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:meetup]
  end

  it "can sign in with meetup" do
    visit login_path
    within('.meetup-login') do
      click_link
    end
    expect(page).to have_content("Welcome Elvis Costello")
    expect(User.count).to eq(1)
    expect(User.first.uid).to eq(1)
  end
end