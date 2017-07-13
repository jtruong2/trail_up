class HikingProjectService
  
  def initialize(lat, long, add_params)
    @lat = lat
    @long = long
    @add_params = add_params
    @conn = Faraday.new(:url => 'https://www.hikingproject.com')
  end

  def self.search(lat=39.739236, long=-104.990251, add_params={})
    response = new(lat, long, add_params).search
    JSON.parse(response, :symbolize_names => true)
  end

  def search
    response = conn.get '/data/get-trails', {:key => ENV['hiking_project_api_key'], :lat => lat, :lon => long, :maxResults=> 50}.merge(add_params)
    response.body
  end

  private
    attr_reader :lat, :long, :add_params, :conn
end