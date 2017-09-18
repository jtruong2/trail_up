def stub_twitter
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    :provider => "twitter",
    :uid => "1234567",
    :info => {
      :nickname => "johnqpublic",
      :name => "John Q Public",
      :location => "Anytown, USA",
      :image => "http://si0.twimg.com/sticky/default_profile_images/default_profile_2_normal.png",
      :description => "a very normal guy.",
      :urls => {
        :Website => nil,
        :Twitter => "https://twitter.com/johnqpublic"
        }
      },
    :credentials => {
    :token => "a1b2c3d4...",
    :secret => "abcdef1234"
    }
  })
end
