require 'rails_helper'

RSpec.describe 'User can edit a trail' do

  before do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  context 'Edits a trail happy path' do
    it 'visits edit trail page' do
      trail = create(:trail)

      visit("trails/#{trail.id}")
      click_link('Edit Trail')

      expect(page).to have_current_path("/trails/#{trail.id}/edit")
      expect(page).to have_content('Edit Trail')
      within('form') do
        expect(page).to have_selector("input[value='#{trail.name}']")
        expect(page).to have_selector("input[value='#{trail.description}']")
        expect(page).to have_selector("input[value='#{trail.distance}']")
        expect(page).to have_selector("input[value='#{trail.location}']")
        expect(page).to have_select("trail_difficulty_id", selected: trail.difficulty.rating)
      end
    end

    it 'edits a trail' do
      trail = create(:trail)

      visit(edit_trail_path(trail))

      within('form') do
        fill_in "Name", with: 'Super Sick Trail'
        fill_in "Description", with: 'Its so good it hurts'
        select "White", from: "trail[difficulty_id]"
        fill_in "Location", with: 'Denver'
        fill_in "Distance", with: '45'
        click_on 'Update Trail'
      end

      expect(page).to have_current_path("/trails/#{trail.id}")
      expect(page).to have_content('Trail Updated')

      expect(page).to have_content('Super Sick Trail')
      expect(page).to have_content('Its so good it hurts')
      expect(page).to have_content('White')
      expect(page).to have_content('Denver')
      expect(page).to have_content('45')
    end
  end

  context 'Edits a trail sad path' do

    it 'edits a trail with blank attributes' do
      trail = create(:trail)

      visit(edit_trail_path(trail))

      within('form') do
        fill_in "Name", with: ''
        fill_in "Description", with: ''
        fill_in "Distance", with: ''
      end

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Description can't be blank")
      expect(page).to have_content("Distance can't be blank")
    end
  end
end