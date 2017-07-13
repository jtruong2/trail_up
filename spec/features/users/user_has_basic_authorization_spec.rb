require 'rails_helper'

describe "User has basic authorization" do
  scenario "user can only see their profile page" do
    user_1 = create(:user)
    user_2 = create(:user, username: "the second user")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    
  end
end
