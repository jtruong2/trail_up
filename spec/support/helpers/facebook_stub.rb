def stub_facebook
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    provider: 'facebook',
    uid: '1',
    info: {
      email: 'joe@bloggs.com',
      name: 'Joe Bloggs',
      first_name: 'Joe',
      last_name: 'Bloggs',
      image: 'http://graph.facebook.com/1234567/picture?type=square',
      verified: true
    },
    credentials: {
      token: 'ABCDEF...',
      expires_at: 1321747205,
      expires: true
    }
  })
end
