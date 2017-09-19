class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, :authorize!

  def receive
    response = Twilio::TwiML::Response.new do |r|
      r.Sms "Well done building your first Twilio on Rails 5 app!"
    end
    render :xml => response.to_xml
  end

  def send
    binding.pry
    to         = params["to"].to_i
    message    = params["body"]
    phone      = ENV["PHONE_NUMBER"].to_i
    twilio_id  = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]

    client = Twilio::REST::Client.new(twilio_id, auth_token)

    client.messages.create(
      to: to,
      from: phone,
      body: message
    )
  end
end
