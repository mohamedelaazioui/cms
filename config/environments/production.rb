require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Turn on fragment caching in view templates.
  config.action_controller.perform_caching = true

  # Cache assets for far-future expiry since they are all digest stamped.
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  
  # Enable serving of static files for Heroku
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Assume all access to the app is happening through a SSL-terminating reverse proxy.
  config.assume_ssl = true

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Skip http-to-https redirect for the default health check endpoint.
  # config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  # Log to STDOUT with the current request id as a default log tag.
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  # Change to "debug" to log everything (including potentially personally-identifiable information!)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Prevent health checks from clogging up the logs.
  config.silence_healthcheck_path = "/up"

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Replace the default in-process memory cache store with a durable alternative.
  # Use Redis if available, otherwise fall back to memory store
  if ENV["REDIS_URL"].present?
    config.cache_store = :redis_cache_store, { url: ENV["REDIS_URL"] }
  else
    config.cache_store = :memory_store
  end

  # Replace the default in-process and non-durable queuing backend for Active Job.
  # Use async adapter on Heroku (DYNO env var is set by Heroku)
  # Use Solid Queue on other platforms if database supports it
  if ENV["DYNO"].present?
    config.active_job.queue_adapter = :async
  else
    begin
      config.active_job.queue_adapter = :solid_queue
      config.solid_queue.connects_to = { database: { writing: :queue } }
    rescue StandardError
      config.active_job.queue_adapter = :async
    end
  end

  # Raise email delivery errors to surface SMTP problems
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true

  # Set host to be used by links generated in mailer templates.
  config.action_mailer.default_url_options = { host: ENV.fetch('MAILER_HOST', 'gibugumi.com') }
  
  # Configure SMTP only if credentials are available
  if ENV['MAILTRAP_PASSWORD'].present?
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name: ENV.fetch('MAILTRAP_USER', 'api'),
      password: ENV['MAILTRAP_PASSWORD'],
      address: ENV.fetch('MAILTRAP_HOST', 'live.smtp.mailtrap.io'),
      domain: ENV.fetch('MAILER_HOST', 'gibugumi.com'),
      port: ENV.fetch('MAILTRAP_PORT', '587'),
      authentication: :login,
      enable_starttls_auto: true
    }
  else
    # Fallback to test mode if SMTP credentials not available
    config.action_mailer.delivery_method = :test
    Rails.logger.warn "MAILTRAP_PASSWORD not set. Email delivery disabled."
  end

  # Specify outgoing SMTP server. Remember to add smtp/* credentials via rails credentials:edit.
  # config.action_mailer.smtp_settings = {
  #   user_name: Rails.application.credentials.dig(:smtp, :user_name),
  #   password: Rails.application.credentials.dig(:smtp, :password),
  #   address: "smtp.example.com",
  #   port: 587,
  #   authentication: :plain
  # }

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Only use :id for inspections in production.
  config.active_record.attributes_for_inspect = [ :id ]

  # Enable DNS rebinding protection and other `Host` header attacks.
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  #
  # Skip DNS rebinding protection for the default health check endpoint.
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
