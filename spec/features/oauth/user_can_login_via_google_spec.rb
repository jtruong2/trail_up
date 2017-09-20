require 'rails_helper'
RSpec.describe "User google oauth" do
  it "logs in using google sign in" do
    stub_google
    visit root_path
    click_on "Login"
    within('.google-login') do
      click_link
    end
    
    expect(page).to have_content("Phillis")
    expect(User.count).to eq(1)
    expect(User.first.uid).to eq(1)
  end
end
