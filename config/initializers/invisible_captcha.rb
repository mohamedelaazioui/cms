# Invisible Captcha Configuration
InvisibleCaptcha.setup do |config|
  # Timestamp threshold: minimum time (in seconds) for form submission
  # Set to 1 second to allow quick but not instant submissions
  config.timestamp_threshold = 1
  
  # Enable/disable timestamp validation
  config.timestamp_enabled = true
  
  # Honeypots - field names that bots fill but humans don't see
  config.honeypots = [:subtitle, :topic]
  
  # Disable during test environment
  config.injectable_styles = false if Rails.env.test?
end
