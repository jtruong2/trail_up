require 'rails_helper'

RSpec.describe "As a guest" do

  it "does not see event link" do
    visit root_path
    
    expect(page).to_not have_content("Create Event")

  end
  it "cannot create an event" do

    visit new_trails_select_path

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Not a member?")
  end
end
