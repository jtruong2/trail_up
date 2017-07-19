source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.2'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# gem 'jbuilder', '~> 2.5'
gem 'figaro'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'

gem 'bcrypt', '~> 3.1.7'
gem 'faraday'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'kaminari'
gem 'carrierwave', '~> 1.0'
gem 'will_paginate', '~> 3.1.0'
gem 'geocoder'
gem 'faker'
gem 'humanize'
gem 'fog-aws'
gem "d3-rails"

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'pry-rails'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'simplecov'
  gem 'rubocop', require: false
end
