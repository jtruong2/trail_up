class Weather

  attr_reader :summary, :icon
  
  def initialize(weather_atts={})
    binding.pry
  end

  def self.weather_info(lat,lon)
    info = WeatherService.new.weather_info(lat,lon)[:current_observation]
      Weather.new(info)
  end
end
