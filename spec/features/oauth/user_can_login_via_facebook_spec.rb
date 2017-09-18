require 'rails_helper'
RSpec.describe "User facebook oauth" do
  it "logs in using facebook" do
    stub_facebook

    visit root_path
    click_on "Login"
    within(".facebook-login") do
      click_link
    end
    
    expect(page).to have_content("Joe")
    expect(User.count).to eq(1)
    expect(User.first.uid).to eq(1)
  end
end
