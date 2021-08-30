# frozen_string_literal: true

class Rack::Attack
  # Always allow (blocklist & throttles are skipped) requests from localhost
  safelist('allow from localhost') do |req|
    %w[127.0.0.1 0.0.0.0 ::1].include? req.ip
  end

  # Block signup/login attempts from datacenters, co-location centers, shared and virtual web hosting providers.
  # In other words, IP addresses that end web consumers should not be using.
  blocklist('bad_login_ip') do |req|
    req.post? && %w[/signup /login].include?(req.path) && IPCat.datacenter?(req.ip)
  end

  # Exponential backoff for all requests to "/" path
  #
  # Allows 240 requests/IP in ~8 minutes
  #        480 requests/IP in ~1 hour
  #        960 requests/IP in ~8 hours (~2,880 requests/day)
  (3..5).each do |level|
    throttle("req/ip/#{level}",
             limit: (30 * (2**level)),
             period: (0.9 * (8**level)).to_i.seconds) do |req|
      req.ip if req.path == '/'
    end
  end
end
