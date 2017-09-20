def stub_meetup
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:meetup] = OmniAuth::AuthHash.new(
    {"provider"=>"meetup",
      "uid"=>1,
      "info"=>
    {"id"=>0,
      "name"=>"Elvis Costello",
      "photo_url"=>"http://photos3.meetupstatic.com/photos/member_pic_0.jpeg"},
      "credentials"=>
    {"token"=>"abc123...",
      "refresh_token"=>"bcd234...",
      "expires_at"=>1324720198,
      "expires"=>true}
    })
end
