class FitbitService

  def initialize(codes = nil, user)
    @codes = codes
    @fitbit_user = ""
    @user = user
    @token = ""
    @conn = Faraday.new(:url => 'https://api.fitbit.com')
  end

  def start_collection
    @fitbit_user = codes[1].split('=')[1]
    @token = codes[0]
    verify_or_refresh_token
  end

  def verify_or_refresh_token
    user.fitbit_token = token
    user.fitbit_refresh = Time.new.hour
    user.save
  end

  def date_time_checker
    current_hour = Time.new.hour
    return true if current_hour - user.fitbit_refresh <= 8
  end

  def get_user_data
    response = conn.get("/1/user/-/profile.json") do |request|
      request.headers['Authorization'] = "Bearer #{token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :user, :conn, :fitbit_user, :token, :codes
end
