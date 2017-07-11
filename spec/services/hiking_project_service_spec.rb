require 'rails_helper'

describe HikingProjectService do
  context ".search" do
    it 'returns a default list of trails' do
      VCR.use_cassette('hiking_project_services/default_trail_info') do
        default_trails = HikingProjectService.search
        trail = default_trails[:trails].first

        expect(default_trails[:trails].count).to eq(10)
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
        trails = HikingProjectService.search(39.653599, -105.1911)
        trail = trails[:trails].last

        expect(trails[:trails].count).to eq(10)
        expect(trails).to have_key(:trails)
        expect(trails).to have_key(:success)
        expect(trail[:id]).to eq(7017569)
        expect(trail[:name]).to eq("Marshall Mesa to Spring Brook Loop")
        expect(trail[:type]).to eq("Featured Hike")
        expect(trail[:summary]).to eq("Some of the best trails that Boulder has to offer with a variety of options that never get old.")
        expect(trail[:difficulty]).to eq("greenBlue")
        expect(trail[:stars]).to eq(4.5)
        expect(trail[:location]).to eq("Superior, Colorado")
        expect(trail[:url]).to eq("https://www.hikingproject.com/trail/7017569/marshall-mesa-to-spring-brook-loop")
        expect(trail[:imgSmall]).to eq("https://cdn-files.apstatic.com/hike/7002458_small_1428468752.jpg")
        expect(trail[:length]).to eq(11.1)
        expect(trail[:longitude]).to eq(-105.2313)
        expect(trail[:latitude]).to eq(39.9527)
      end
    end
    it 'returns a list of trails based on all params' do
      VCR.use_cassette('hiking_project_services/all_params_filter') do
        trails = HikingProjectService.search(39.633321, -105.317215, {maxDistance: 150, maxResults: 20, sort: "distance", minLength: 6})
        trail_first = trails[:trails].first
        trail_last = trails[:trails].last

        expect(trails[:trails].count).to eq(20)
        expect(trail_first[:id]).to eq(7003115)
        expect(trail_last[:id]).to eq(7029735)
      end
    end
  end
end

