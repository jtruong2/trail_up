require 'rails_helper'

describe "User has basic authorization" do
  scenario "user can only see their profile page" do
    user_1 = create(:user)
    user_2 = create(:user, username: "the second user", email: "hello@gmail.com")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit user_path(:id => user_1.slug)
    expect(page).to have_content(user_1.username)

    visit "/users/the-second-user"
    expect(page).to_not have_content(user_2.username)
    expect(current_path).to eq('/')
  end

  scenario "user can't view admin pages" do

  end
end
