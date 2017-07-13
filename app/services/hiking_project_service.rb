class HikingProjectService
  
  def initialize(coords, add_params)
    @lat = coords[:lat]
    @long = coords[:lng]
    @add_params = add_params
    @conn = Faraday.new(:url => 'https://www.hikingproject.com')
  end

  def self.search(coords={ :lat=> 39.742043, :lng=> -104.991531 }, add_params={})
    response = new(coords, add_params).search
    JSON.parse(response, :symbolize_names => true)
  end

  def search
    response = conn.get '/data/get-trails', {:key => ENV['hiking_project_api_key'], :lat => lat, :lon => long, :maxResults=> 50}.merge(add_params)
    response.body
  end

  private
    attr_reader :lat, :long, :add_params, :conn
end