require 'rails_helper'
RSpec.describe "User twitter oauth" do
  it "logs in using twitter" do
    stub_twitter

    visit root_path
    click_on "Login"
    within(".twitter-login") do
      click_link
    end

    expect(page).to have_content("John Q Public")
    expect(User.count).to eq(1)
    expect(User.first.uid).to eq(1)
  end
end
