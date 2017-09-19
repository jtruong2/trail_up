require 'twilio-ruby'

class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authorize!

  def respond_and_receive
    personal_number = params["From"]
    user_msg        = params["Body"]
    response_msg    = "You would like that...Des"
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
end
