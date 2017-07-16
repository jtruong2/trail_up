class FitbitController < ApplicationController

  def index
  end

  def login
    conn = Faraday.new(:url => 'https://www.fitbit.com')
    response = conn.post "/oauth2/authorize" do |request|
      request.params['response_type'] = 'token'
      request.params['client_id'] = ENV['fitbit_oauth_client_id']
      request.params['scope'] = "activity, heartrate, location, profile, weight"
      request.params['redirect_url'] = 'https://localhost:3000/auth/fitbit/callback'
      request.params['expires_in'] = '2592000'
    end
  end

end
