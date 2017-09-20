require 'rails_helper'

describe "Similar Trails" do
  it "returns similar trails" do
    
    diff = create(:difficulty)
    trail = create(:trail, difficulty_id: diff.id)
    trail2 = create(:trail, difficulty_id: diff.id)
    trail3 = create(:trail, difficulty_id: diff.id)
    visit "/trails/#{trail.id}"

    expect(page).to have_content(trail2.name)
    expect(page).to have_content(trail3.name)
  end
end
