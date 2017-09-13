class Weather

  attr_reader :summary, :icon
  
  def initialize(weather_atts={})
    @summary = weather_atts[:fcttext_metric]
    @icon = weather_atts[:icon_url]
  end

  def self.weather_info(lat,lon)
    WeatherService.new.weather_info(lat,lon)[:forecast][:txt_forecast][:forecastday].map do |raw|
      Weather.new(raw)
    end
  end
end
