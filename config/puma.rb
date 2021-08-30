# frozen_string_literal: true

# Inspired by official Heroku guide: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
#
# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
threads_count = ENV.fetch('RAILS_MAX_THREADS', 5)
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port ENV.fetch('PORT', 3000)

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

before_fork do
  require 'puma_worker_killer'

  PumaWorkerKiller.enable_rolling_restart # Default is every 6 hours
end

# on_worker_boot do
#   Barnes.start
# end