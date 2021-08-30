ENV['RAILS_ENV'] = 'test'

require 'spec_helper'

begin
  require File.expand_path('../../config/environment', __FILE__)
rescue StandardError => e
  # Fail fast if application couldn't be loaded
  $stdout.puts "Failed to load the app: #{e.message}\n#{e.backtrace.take(5).join("\n")}"
  exit(1)
end

# Prevent from running in non-test environment
abort("The Rails environment is running in #{Rails.env} mode!") unless Rails.env.test?

require 'rspec/rails'
require 'database_cleaner'

# Allows rspec runs in Docker.
# Ref: https://github.com/DatabaseCleaner/database_cleaner#safeguards
DatabaseCleaner.allow_remote_database_url = true

# DatabaseCleaner and other support files
# Dir[Rails.root.join('spec/support/**/*.rb')].each  { |f| require f }
Dir[File.join(__dir__, 'support/**/*.rb')].sort.each { |file| require file }
Dir[Rails.root.join('spec/**/concerns/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/**/shared_examples/*.rb')].each { |f| require f }

RSpec.configure do |c|
  c.include VideoFeed
end

RSpec.configure do |config|
  # See https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  config.define_derived_metadata(file_path: %r{/spec/}) do |metadata|
    # do not overwrite type if it's already set
    next if metadata.key?(:type)

    match = metadata[:location].match(%r{/spec/([^/]+)/})
    metadata[:type] = match[1].singularize.to_sym
  end

  # Named routes are not available in specs by default, add them.
  config.include Rails.application.routes.url_helpers

  config.filter_rails_from_backtrace!

  # Request/Rack middlewares
  config.filter_gems_from_backtrace 'railties', 'rack', 'rack-test'

  # Add `travel_to`
  # See https://andycroll.com/ruby/replace-timecop-with-rails-time-helpers-in-rspec/
  config.include ActiveSupport::Testing::TimeHelpers

  config.after do
    Rails.cache.clear

    # Make sure every example starts with the current time
    travel_back
  end

  # Include FactoryBot so we can, for example, use 'create' instead of 'FactoryBot.create'
  config.include FactoryBot::Syntax::Methods
end

def sample_video
  sample_video_feed
end
