require 'twilio-ruby'
require 'json'
require 'excon'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize!

  def respond_and_receive
    personal_number = params["From"]
    user_msg        = params["Body"]
    response_msg    = trudy_response(user_msg)
    app_number      = ENV["PHONE_NUMBER"]
    twilio_id       = ENV["ACCOUNT_SID"]
    auth_token      = ENV["AUTH_TOKEN"]

    client = Twilio::REST::Client.new(twilio_id, auth_token)

    client.messages.create(
      to: personal_number,
      from: app_number,
      body: response_msg
    )
  end

  def trudy_response(user_msg)
    response = Excon.post(ENV["TRUDY_URL"],
      text: user_msg,
      headers: { "Content-Type" => "application/json" },
      user: ENV["USERNAME"],
      password: ENV["PASSWORD"],
    )
    JSON.parse(response.body, symbolize_names: true)[:output][:text].first
  end
end
