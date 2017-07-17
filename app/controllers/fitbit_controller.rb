class FitbitController < ApplicationController

  def index
    codes = params[:id]
    results = FitbitService.new(params[:id], current_user).get_user_data
  end

  def login
  end

end

# https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=228NTW&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fauth%2Ffitbit%2Fcallback&scope=activity%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=604800

# binding.pry
# conn = Faraday.new(:url => 'https://www.fitbit.com')
# response = conn.post "/oauth2/authorize" do |request|
#   request.params['response_type'] = 'token'
#   request.params['client_id'] = ENV['fitbit_oauth_client_id']
#   request.params['scope'] = "activity, heartrate, location, profile, weight"
#   request.params['redirect_url'] = 'https://localhost:3000/auth/fitbit/callback'
#   request.params['scope'] =
#   request.params['expires_in'] = '2592000'
# end
