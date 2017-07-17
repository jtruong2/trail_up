class FitbitService

  def initialize(codes, user)
    @fitbit_user = codes[1].split('=')[1]
    @user = user
    @token = codes[0]
    @conn = Faraday.new(:url => 'https://api.fitbit.com')
  end

  def get_user_data
    get_activity_data
  end

  def get_activity_data
    response = conn.get("/1/#{user}-id/-/profile") do |request|
      request.headers['Authorization'] = "Bearer #{token}"
    end
  end


  private

  attr_reader :user, :conn, :fitbit_user, :token
end
