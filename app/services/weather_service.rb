class WeatherService
  
  def initialize
    @conn ||= Faraday.new(url: "http://api.wunderground.com/api/#{ENV['WEATHER_KEY']}") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def weather_info(lat,lon)
    parse(@conn.get("forecast/q/#{lat},#{lon}.json"))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
