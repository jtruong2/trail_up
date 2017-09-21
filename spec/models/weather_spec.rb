require 'rails_helper'

describe 'weather info' do
  it 'returns weather info for a trail' do

    weather = Weather.weather_info(40.13,-103.01)
    wea = weather.first

    expect(wea).to respond_to(:date)
    expect(wea).to respond_to(:low)
    expect(wea).to respond_to(:high)
    expect(wea).to respond_to(:icon)
  end
end
