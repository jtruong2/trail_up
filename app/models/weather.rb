class Weather

  attr_reader :summary, :temp, :wind
  
  def initialize(weather_atts={})
    @summary = weather_atts[:weather]
    @temp = weather_atts[:temperature_string]
    @wind = weather_atts[:wind_mph]
  end

  def self.weather_info(lat,lon)
    info = WeatherService.new.weather_info(lat,lon)[:current_observation]
      Weather.new(info)
  end
end
