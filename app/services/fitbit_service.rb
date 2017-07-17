class FitbitService

  def initialize(codes, user)
    @fitbit_user = codes[1].split('=')[1]
    @user = user
    @token = codes[0]
    @conn = Faraday.new(:url => 'https://api.fitbit.com')
  end

  def start_collection
    verify_or_refresh_token
    get_user_data
  end

  def verify_or_refresh_token

  end

  def get_user_data
    response = conn.get("/1/user/-/profile.json") do |request|
      request.headers['Authorization'] = "Bearer #{token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :user, :conn, :fitbit_user, :token
end
