require 'rails_helper'

describe HikingProjectService do
  it 'returns a default list of trails' do
    VCR.use_cassettes('services/default_trail_info') do
      default_trails = HikingProjectService.search(ENV['hiking_project_api_key'])
      trail = default_trails[:items].first

      expect(default_trails.count).to eq(50)
      expect(default_trails).to have_key(:items)
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
      expect(trail[:url]).to be_an String
      expect(trail).to have_key(:length)
      expect(trail[:length]).to be_an Float
      expect(trail).to have_key(:longitude)
      expect(trail[:longitude]).to be_an Float
      expect(trail).to have_key(:latitude)
      expect(trail[:longitude]).to be_an Float 
    end
  end
end

