require 'rails_helper'

RSpec.describe 'User can edit a trail' do

  it 'visits edit trail page' do
    trail = create(:trail)

    visit("trails/#{trail.id}")
    click_link('Edit Trail')

    expect(page).to have_current_path("trails/#{trail.id}/edit")
    expect(page).to have_content('Edit Trail')
    within('form') do
      expect(page).to have_selector("input", :value =>"Name")
      expect(page).to have_selector("input", :value =>"Description")
      expect(page).to have_selector("input", :value =>"Difficulty")
      expect(page).to have_selector("input", :value =>"Distance")
      expect(page).to have_selector("input", :value =>"Location")
    end
  end

  it 'edits a trail' do
    trail = create(:trail)

    visit(edit_trail_path(trail))

    within('form') do
      fill_in "Name", with: 'Super Sick Trail'
      fill_in "Description", with: 'Its so good it hurts'
      select "White", from: "trail[difficulty]"
      fill_in "Location", with: 'Denver'
      fill_in "Distance", with: '45'
      click_on 'Submit'
    end

    expect(page).to have_current_path("trails/#{trail.id}")
    expect(page).to have_content('Edit Successfull')

    expect(page).to have_content('Super Sick Trail')
    expect(page).to have_content('Its so good it hurts')
    expect(page).to have_content('White')
    expect(page).to have_content('Denver')
    expect(page).to have_content('45')
  end
end