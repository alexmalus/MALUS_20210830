# frozen_string_literal: true

# Enables browsers to view the web server as a: PWA (Progressive Web App).
# Ref: https://developers.google.com/web/ilt/pwa/introduction-to-service-worker
class ServiceWorkerController < ApplicationController
  protect_from_forgery except: :service_worker

  def service_worker; end
  def manifest; end
end
