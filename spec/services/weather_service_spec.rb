require 'rails_helper'

describe WeatherService do
  context "retrieves weather info for trails" do
    it ".weather_info" do
      
      weather = WeatherService.new.weather_info(40.13,-103.01)

      expect(weather.class).to eq(Hash)
      expect(weather).to have_key(:forecast)
    end
  end
end
