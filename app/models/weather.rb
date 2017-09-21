class Weather

  attr_reader :high, :low, :condition, :icon, :date

  def initialize(weather_atts={})
    @date = weather_atts[:date][:weekday]
    @high = weather_atts[:high][:fahrenheit]
    @low = weather_atts[:low][:fahrenheit]
    @condition = weather_atts[:conditions]
    @icon = weather_atts[:icon_url]
  end

  def self.weather_info(lat,lon)
    WeatherService.new.weather_info(lat,lon)[:forecast][:simpleforecast][:forecastday].map do |info|
      Weather.new(info)
    end
  end
end
