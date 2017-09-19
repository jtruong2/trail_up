require 'sinatra'
require 'twilio-ruby'

post '/receive_sms' do
  content_type 'text/xml'

  response = Twilio::TwiML::Response.new do |response|
    r.Message "Hey, I work!"
  end
  response.to_xml
end
