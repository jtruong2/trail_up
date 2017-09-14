require 'rails_helper'

describe 'weather info' do
  it 'returns weather info for a trail' do
    
    weather = Weather.weather_info(40.13,-103.01)

    expect(weather).to respond_to(:summary)
    expect(weather).to respond_to(:temp)  
    expect(weather).to respond_to(:wind)
  end
end
