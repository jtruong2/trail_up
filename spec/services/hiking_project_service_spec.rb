require 'rails_helper'

describe HikingProjectService do
  context ".search" do
    it 'returns a default list of trails' do
      VCR.use_cassette('hiking_project_services/default_trail_info') do
        default_trails = HikingProjectService.search
        trail = default_trails[:trails].first

        expect(default_trails[:trails].count).to eq(50)
        expect(default_trails).to have_key(:trails)
        expect(default_trails).to have_key(:success)
        expect(trail).to have_key(:id)
        expect(trail[:id]).to be_an Integer
        expect(trail).to have_key(:name)
        expect(trail[:name]).to be_an String
        expect(trail).to have_key(:type)
        expect(trail[:type]).to be_an String
        expect(trail).to have_key(:summary)
        expect(trail[:summary]).to be_an String
        expect(trail).to have_key(:difficulty)
        expect(trail[:difficulty]).to be_an String
        expect(trail).to have_key(:stars)
        expect(trail[:stars]).to be_an Float
        expect(trail).to have_key(:location)
        expect(trail[:location]).to be_an String
        expect(trail).to have_key(:url)
        expect(trail[:url]).to be_an String
        expect(trail).to have_key(:imgSmall)
        expect(trail[:imgSmall]).to be_an String
        expect(trail).to have_key(:length)
        expect(trail[:length]).to be_an Float
        expect(trail).to have_key(:longitude)
        expect(trail[:longitude]).to be_an Float
        expect(trail).to have_key(:latitude)
        expect(trail[:latitude]).to be_an Float
      end
    end
    it 'returns a list of trails based on long and lat' do
      VCR.use_cassette('hiking_project_services/lat_long_trail_info') do
        trails = HikingProjectService.search({lat: 39.653599, lon: -105.1911, maxResults: 50})
        trail = trails[:trails].last

        expect(trails[:trails].count).to eq(50)
        expect(trails).to have_key(:trails)
        expect(trails).to have_key(:success)
        expect(trail[:id]).to eq(7004681)
        expect(trail[:name]).to eq("South Mesa Loop")
        expect(trail[:type]).to eq("Featured Hike")
        expect(trail[:summary]).to eq("Stunning scenery and a little history...")
        expect(trail[:difficulty]).to eq("greenBlue")
        expect(trail[:stars]).to eq(3.7)
        expect(trail[:location]).to eq("Superior, Colorado")
        expect(trail[:url]).to eq("https://www.hikingproject.com/trail/7004681/south-mesa-loop")
        expect(trail[:imgSmall]).to eq("https://cdn-files.apstatic.com/hike/7000477_small_1420779399.jpg")
        expect(trail[:length]).to eq(3)
        expect(trail[:longitude]).to eq(-105.2582)
        expect(trail[:latitude]).to eq(39.9388)
      end
    end
    it 'returns a list of trails based on all params' do
      VCR.use_cassette('hiking_project_services/all_params_filter') do
        trails = HikingProjectService.search({lat: 39.633321, lon: -105.317215, maxDistance: 150, maxResults: 20, sort: "distance", minLength: 6})
        trail_first = trails[:trails].first
        trail_last = trails[:trails].last

        expect(trails[:trails].count).to eq(20)
        expect(trail_first[:id]).to eq(7003115)
        expect(trail_last[:id]).to eq(7029735)
      end
    end
  end
end

