class HikingProjectService

  def self.search(lat=39.739236, long=-104.990251)
    conn = Faraday.new(:url => 'https://www.hikingproject.com')
    response = conn.get '/data/get-trails', {:key => ENV['hiking_project_api_key'], :lat => lat, :lon => long}
    JSON.parse(response.body, :symbolize_names => true)
  end

end