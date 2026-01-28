# Tracking and Analytics Configuration
# Replace these placeholder values with your actual tracking IDs

Rails.application.config.x.tracking = {
  google_analytics: ENV.fetch('GOOGLE_ANALYTICS_ID', nil),
  facebook_pixel: ENV.fetch('FACEBOOK_PIXEL_ID', nil),
  google_tag_manager: ENV.fetch('GOOGLE_TAG_MANAGER_ID', nil)
}

# To set up your tracking IDs:
# 1. Google Analytics: Create a GA4 property at https://analytics.google.com
#    - Get your Measurement ID (format: G-XXXXXXXXXX)
#    - Set environment variable: GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
#
# 2. Facebook Pixel: Create a pixel at https://business.facebook.com
#    - Get your Pixel ID (numeric value)
#    - Set environment variable: FACEBOOK_PIXEL_ID=123456789012345
#
# 3. In production, set these as environment variables:
#    export GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
#    export FACEBOOK_PIXEL_ID=123456789012345
