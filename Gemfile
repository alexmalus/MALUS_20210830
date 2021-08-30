# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 6.1.4'

gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

# Drivers
gem 'pg', '1.2.3'

gem 'puma', '~> 5.0'
gem 'puma_worker_killer'

# Security
gem 'bcrypt', '~> 3.1.7'
gem 'rack-attack'
gem 'ipcat'

# Other
gem 'bootsnap', '>= 1.4.4', require: false

# UI
gem 'rails_heroicons', '~> 0.6.0'

# Monitoring
gem 'scout_apm', '~> 2.6.7'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0', '>= 5.0.1'
  gem 'factory_bot_rails'

  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'

  # Code critics
  gem 'rubocop-rspec'
  gem 'rubocop-rails'
  gem 'brakeman'
end

group :test do
  gem 'database_cleaner'
end

gem 'shrine', '~> 3.3'
gem 'aws-sdk-s3', '~> 1.14'
gem 'uppy-s3_multipart', '>= 0.3.2'
gem 'marcel'
gem 'fastimage'

gem 'sucker_punch'
gem 'streamio-ffmpeg'
