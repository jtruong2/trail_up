require "rails_helper"

describe HPTrail do
  context 'Object wraps data for hiking project service api call' do
    it "returns data" do

      allow_any_instance_of(HikingProjectService).to receive(:search).and_return(open_fixture('spec/support/fixtures/hiking_project_trails.json'))
      coordinates = { lat: 39.742043, lng: -104.991531 }
      trails = HikingProjectService.search(coordinates)
      hp_trail = HPTrail.new(trails[:trails].first)

      expect(hp_trail.hp_id).to eq(7000130)
      expect(hp_trail.name).to eq("Bear Peak")
      expect(hp_trail.location).to eq("Boulder, Colorado")
      expect(hp_trail.difficulty).to eq("Blue-black")
      expect(hp_trail.length).to eq("5.7 miles")
      expect(hp_trail.long).to eq(-105.2755)
      expect(hp_trail.lat).to eq(39.9787)
      expect(hp_trail.hp_image).to eq("https://cdn-files.apstatic.com/hike/7005712_small_1436317330.jpg")
      expect(hp_trail.hp_rating).to eq(4.6)
      
    end
  end
end
