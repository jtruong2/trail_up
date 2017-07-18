CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['aws_access_key_id'],
    aws_secret_access_key: ENV['aws_secret_access_key'],
    region:                'us-east-2'
  }

  # For testing, upload files to local `tmp` folder.
  if Rails.env.test? || Rails.env.development?|| Rails.env.rspec?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads" # To let CarrierWave work on heroku
  config.fog_directory = ENV['s3_bucket_name']
end