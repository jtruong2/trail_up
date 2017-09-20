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
        expect(trail[:id]).to eq(7000078)
        expect(trail[:name]).to eq("Shanahan Ridge")
        expect(trail[:type]).to eq("Featured Hike")
        expect(trail[:summary]).to eq("A straightforward hike on some of the best trail Boulder has to offer.")
        expect(trail[:difficulty]).to eq("blue")
        expect(trail[:stars]).to eq(3.5)
        expect(trail[:location]).to eq("Boulder, Colorado")
        expect(trail[:url]).to eq("https://www.hikingproject.com/trail/7000078/shanahan-ridge")
        expect(trail[:imgSmall]).to eq("https://cdn-files.apstatic.com/hike/7000471_small_1420779033.jpg")
        expect(trail[:length]).to eq(4)
        expect(trail[:longitude]).to eq(-105.2668)
        expect(trail[:latitude]).to eq(39.9746)
      end
    end
    it 'returns a list of trails based on all params' do
      VCR.use_cassette('hiking_project_services/all_params_filter') do
        trails = HikingProjectService.search({lat: 39.633321, lon: -105.317215, maxDistance: 150, maxResults: 20, sort: "distance", minLength: 6})
        trail_first = trails[:trails].first
        trail_last = trails[:trails].last

        expect(trails[:trails].count).to eq(20)
        expect(trail_first[:id]).to eq(7003115)
        expect(trail_last[:id]).to eq(7011192)
      end
    end
  end
end
