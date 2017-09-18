class HikingProjectService

  def initialize(search_params)
    @search_params = search_params
    @conn = Faraday.new(:url => 'https://www.hikingproject.com')
  end

  def self.search(search_params = { lat: 39.742043, lon: -104.991531, maxResults: 50 })
    response = new(search_params).search
    JSON.parse(response, :symbolize_names => true)
  end

  def search
    response = conn.get '/data/get-trails', { 'key' => ENV['hiking_project_api_key'] }.merge(search_params)
    response.body
  end

  private
    attr_reader :search_params, :conn
end
