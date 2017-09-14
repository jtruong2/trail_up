def stub_google
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    provider: "google",
    uid: "12345678910",
    info: {
      email: "homies@shelteredhomies.com",
      first_name: "Phillis",
      last_name: "Holland"
    },
    credentials: {
      token: "abcdefg12345",
      refresh_token: "12345abcdefg"
    }
  })
end
