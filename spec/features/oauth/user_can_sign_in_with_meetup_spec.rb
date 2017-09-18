require 'rails_helper'

RSpec.describe "As a user" do
  it "can sign in with meetup" do
    stub_meetup
    visit root_path
    click_link "Login"
    within('.meetup-login') do
      click_link
    end

    expect(page).to have_content("Elvis Costello")
    expect(User.count).to eq(1)
    expect(User.first.uid).to eq(1)
  end
end
