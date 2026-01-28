# SEO and Analytics Setup Guide

## Overview

This CMS includes comprehensive SEO optimization and analytics tracking for:
- Google Analytics 4 (GA4)
- Facebook Pixel
- YouTube traffic tracking (via Google Analytics)
- Social media sharing optimization

## Features Implemented

### 1. SEO Meta Tags
- **Title Tags**: Dynamic page titles with `content_for(:meta_title)`
- **Meta Description**: Customizable descriptions for each page
- **Meta Keywords**: Page-specific keywords
- **Canonical URLs**: Prevent duplicate content issues
- **Language Tags**: Multi-language support (EN/JA)

### 2. Social Media Optimization

#### Open Graph (Facebook, LinkedIn)
- `og:type`, `og:url`, `og:title`, `og:description`, `og:image`
- Automatic locale detection (en_US / ja_JP)
- Site name branding

#### Twitter Cards
- Large image summary cards
- Optimized for Twitter sharing

### 3. Structured Data (JSON-LD)
- Organization schema
- Social media profile links
- Contact information
- Multi-language support indicator

### 4. Analytics & Tracking

#### Google Analytics 4
- Page view tracking
- Custom page titles and paths
- Event tracking ready

#### Facebook Pixel
- Page view tracking
- Conversion tracking ready
- Custom event support

## Setup Instructions

### 1. Google Analytics Setup

1. Create a Google Analytics 4 property:
   - Go to https://analytics.google.com
   - Create a new GA4 property
   - Get your Measurement ID (format: `G-XXXXXXXXXX`)

2. Set the environment variable:
   ```bash
   # Development (.env file)
   GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
   
   # Production
   export GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
   ```

### 2. Facebook Pixel Setup

1. Create a Facebook Pixel:
   - Go to https://business.facebook.com
   - Navigate to Events Manager
   - Create a new Pixel
   - Get your Pixel ID (numeric value)

2. Set the environment variable:
   ```bash
   # Development (.env file)
   FACEBOOK_PIXEL_ID=123456789012345
   
   # Production
   export FACEBOOK_PIXEL_ID=123456789012345
   ```

### 3. YouTube Traffic Tracking

YouTube traffic is automatically tracked through:
- **Google Analytics**: Social referrals from youtube.com
- **UTM Parameters**: Add to YouTube video descriptions:
  ```
  ?utm_source=youtube&utm_medium=video&utm_campaign=campaign_name
  ```

### 4. Social Media Links

Update the structured data in `app/views/layouts/application.html.erb`:

```ruby
"sameAs": [
  "https://www.facebook.com/yourpage",
  "https://www.instagram.com/yourpage",
  "https://www.youtube.com/yourchannel"
]
```

## Customizing SEO Per Page

In any view, you can customize SEO metadata:

```erb
<% content_for :meta_title, "Custom Page Title - CMS" %>
<% content_for :meta_description, "This is a custom description for this page." %>
<% content_for :meta_keywords, "keyword1, keyword2, keyword3" %>
<% content_for :meta_image, "#{request.base_url}/custom-image.jpg" %>
<% content_for :canonical_url, "https://example.com/custom-url" %>
```

## Tracking Custom Events

### Google Analytics Events
```javascript
gtag('event', 'event_name', {
  'event_category': 'category',
  'event_label': 'label',
  'value': 1
});
```

### Facebook Pixel Events
```javascript
fbq('track', 'CustomEvent', {
  content_name: 'Product Name',
  content_category: 'Category',
  value: 19.99,
  currency: 'USD'
});
```

## Testing

### 1. Test SEO Tags
- Use [Facebook Debugger](https://developers.facebook.com/tools/debug/)
- Use [Twitter Card Validator](https://cards-dev.twitter.com/validator)
- Use [Google Rich Results Test](https://search.google.com/test/rich-results)

### 2. Test Analytics
- Google Analytics: Real-time reports
- Facebook Pixel: Test Events in Events Manager
- Use browser dev tools to verify tracking calls

## Performance Considerations

- All tracking scripts load asynchronously
- Conditional loading (only loads when IDs are configured)
- Minimal impact on page load times
- GDPR-compliant cookie consent banner included

## Privacy & GDPR Compliance

The application includes:
- Cookie consent banner (bilingual EN/JA)
- User choice persistence (localStorage)
- Option to decline tracking
- Link to privacy policy in footer

## Monitoring Traffic Sources

In Google Analytics, you can track:
- **Social traffic**: Facebook, Instagram, YouTube, Twitter
- **Direct traffic**: Users typing URL directly
- **Referral traffic**: Links from other websites
- **Search traffic**: Google, Bing, etc.

### YouTube Traffic Reports
1. Go to Google Analytics
2. Navigate to: Acquisition > All Traffic > Source/Medium
3. Filter for `youtube.com` or `m.youtube.com`

## Additional Resources

- [Google Analytics Help](https://support.google.com/analytics)
- [Facebook Pixel Documentation](https://developers.facebook.com/docs/meta-pixel)
- [Schema.org Documentation](https://schema.org/)
- [Open Graph Protocol](https://ogp.me/)

## Support

For issues or questions, check:
- Configuration file: `config/initializers/tracking.rb`
- Helper methods: `app/helpers/application_helper.rb`
- Layout template: `app/views/layouts/application.html.erb`
