require 'rails_helper'

describe "Trail Comments" do
  it "returns a trails comments" do
    
    user = create(:user)
    trail = create(:trail)
    comment = Comment.create(star_rating: 4, body: "dope", trail_id: trail.id, user_id: user.id)

    visit "/trails/#{trail.id}"
    
    expect(page).to have_content("Comments")
    expect(page).to have_content("dope")
  end
end
