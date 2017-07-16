class FitbitService

  def initialize(user)
    @user = user
    @conn = Faraday.new(:url => 'https://www.fitbit.com')
  end

  def test_login
    response = conn.post "/oauth2/authorize" do |request|
      request.params['response_type'] = 'token'
      request.params['client_id'] = ENV['fitbit_oauth_client_id']
      request.params['scope'] = "activity, heartrate, location, profile, weight"
      request.params['redirect_url'] = 'https://localhost:3000/auth/fitbit/callback'
      request.params['expires_in'] = '2592000'
    end
  end

  def login
    response = Faraday.post("https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=#{ENV['fitbit_oauth_client_id']}&redirect_uri=https%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffitbit%2Fcallback&scope=activity%20heartrate%20location%20profile%20social%20weight&expires_in=2592000")
  end


  private

  attr_reader :user, :conn
end
