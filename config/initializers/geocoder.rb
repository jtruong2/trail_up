if Rails.env.test?
  Geocoder.configure(:lookup => :test)
  # Particular Look up
  Geocoder::Lookup::Test.add_stub(
    [30.0, -100.00] , [
      {
        'latitude'     => 30.0,
        'longitude'    => -100.0,
        'address'      => 'Golden, CO, USA',
        'state'        => 'Colorado',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
  Geocoder::Lookup::Test.add_stub(
    [31.0, -101.0], [
      {
        'latitude'     => 31.0,
        'longitude'    => -101.0,
        'address'      => 'Idaho Springs, CO, USA',
        'state'        => 'CO',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
  Geocoder::Lookup::Test.add_stub(
    "Rocksprings,TX", [
      {
        'latitude'     => 30.0,
        'longitude'    => -100.0,
        'address'      => 'Idaho Springs, CO, USA',
        'state'        => 'CO',
        'state_code'   => 'CO',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )
  
  #default stub
  Geocoder::Lookup::Test.set_default_stub(
    [
      {
        'latitude'     => 40.7143528,
        'longitude'    => -74.0059731,
        'address'      => 'New York, NY, USA',
        'state'        => 'New York',
        'state_code'   => 'NY',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ]
  )  
else
  Geocoder.configure(
    :timeout      => 3,           # geocoding service timeout (secs)
    :lookup       => :google,     # name of geocoding service (symbol)
    :language     => :en,         # ISO-639 language code
    :units     => :mi,       # :km for kilometers or :mi for miles
    :distances => :linear    # :spherical or :linear
  )
end