require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
# require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Watcher
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil
    # Disable creation of stylesheets & helpers.
    config.generators.assets = false
    config.generators.helper = false

    # Use SuckerPunch for background jobs.
    config.active_job.queue_adapter = :sucker_punch

    config.autoload_paths += %w[lib]

    # supports :s3, :s3_multipart, or :app
    config.upload_server = if ENV['UPLOAD_SERVER'].present?
                             ENV['UPLOAD_SERVER'].to_sym
                           elsif Rails.env.production?
                             :s3
                           else
                             :app
                           end
  end
end