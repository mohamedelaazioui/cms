# Heroku Deployment Guide

Complete guide for deploying the CMS application to Heroku.

## Prerequisites

1. **Heroku Account**: Sign up at https://heroku.com
2. **Heroku CLI**: Install from https://devcenter.heroku.com/articles/heroku-cli
3. **Git**: Ensure your code is committed

## Quick Deploy

### Option 1: One-Click Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Click the button above or visit your repository on GitHub and use the "Deploy to Heroku" button.

### Option 2: Manual Deployment

#### 1. Login to Heroku

```bash
heroku login
```

#### 2. Create Heroku App

```bash
# Create app (Heroku will assign a name)
heroku create

# OR create with custom name
heroku create your-cms-app-name
```

#### 3. Add PostgreSQL Database

```bash
# Add PostgreSQL addon (free tier)
heroku addons:create heroku-postgresql:essential-0

# Verify database is attached
heroku addons:info postgresql
heroku config:get DATABASE_URL
```

#### 4. Configure Environment Variables

```bash
# Generate and set SECRET_KEY_BASE
heroku config:set SECRET_KEY_BASE=$(rails secret)

# Set Rails environment
heroku config:set RAILS_ENV=production
heroku config:set RACK_ENV=production

# Enable static file serving and logging
heroku config:set RAILS_SERVE_STATIC_FILES=enabled
heroku config:set RAILS_LOG_TO_STDOUT=enabled

# Set application version
heroku config:set APP_VERSION=1.0.0

# Optional: Set master key for credentials (if using encrypted credentials)
# heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)

# Optional: Analytics
# heroku config:set GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
# heroku config:set FACEBOOK_PIXEL_ID=123456789012345
```

#### 5. Deploy to Heroku

```bash
# Push to Heroku
git push heroku main

# OR if you're on a different branch
git push heroku your-branch:main
```

#### 6. Run Database Migrations

```bash
# Migrations run automatically via Procfile release phase
# But you can also run manually:
heroku run rails db:migrate
```

#### 7. Seed Initial Data

```bash
# Seed the database with initial data
heroku run rails db:seed
```

#### 8. Open Your App

```bash
heroku open
```

## Post-Deployment Setup

### 1. Change Admin Password

```bash
# Open Rails console
heroku run rails console

# In the console:
admin = Admin.first
admin.password = "new_secure_password"
admin.password_confirmation = "new_secure_password"
admin.save!
exit
```

### 2. Configure Custom Domain (Optional)

```bash
# Add custom domain
heroku domains:add www.your-domain.com

# Get DNS target
heroku domains

# Add CNAME record in your DNS:
# www.your-domain.com -> your-app-name.herokuapp.com
```

### 3. Enable SSL (Automatic with Heroku)

Heroku provides free automated SSL for all apps. No configuration needed!

## Monitoring & Maintenance

### View Logs

```bash
# View recent logs
heroku logs --tail

# Filter for errors
heroku logs --tail | grep ERROR

# View specific number of lines
heroku logs -n 500
```

### Check Application Status

```bash
# Check dyno status
heroku ps

# Check app info
heroku info

# Check configuration
heroku config
```

### Access Rails Console

```bash
heroku run rails console
```

### Run Rake Tasks

```bash
heroku run rails db:migrate
heroku run rails db:seed
heroku run rails routes
```

### Database Management

```bash
# Database backup (requires paid plan or backup addon)
heroku pg:backups:capture
heroku pg:backups:download

# Database info
heroku pg:info

# Database console
heroku pg:psql
```

### Restart Application

```bash
heroku restart
```

## Scaling

### Vertical Scaling (Upgrade Dyno)

```bash
# List available dyno types
heroku ps:type --help

# Upgrade to Standard-1X
heroku ps:type web=standard-1x
```

### Horizontal Scaling (Add More Dynos)

```bash
# Scale to 2 web dynos
heroku ps:scale web=2

# Scale back to 1
heroku ps:scale web=1
```

## Troubleshooting

### App Crashes on Startup

```bash
# Check logs for errors
heroku logs --tail

# Common issues:
# 1. Missing SECRET_KEY_BASE
heroku config:set SECRET_KEY_BASE=$(rails secret)

# 2. Database not migrated
heroku run rails db:migrate

# 3. Assets not precompiled (should happen automatically)
heroku run rails assets:precompile
```

### Database Connection Issues

```bash
# Verify DATABASE_URL is set
heroku config:get DATABASE_URL

# Reset database (⚠️ DESTRUCTIVE)
heroku pg:reset DATABASE
heroku run rails db:migrate db:seed
```

### "We're sorry, but something went wrong" Error

```bash
# Enable detailed errors temporarily
heroku config:set RAILS_LOG_LEVEL=debug

# Check logs
heroku logs --tail

# Disable after debugging
heroku config:unset RAILS_LOG_LEVEL
```

### Memory Issues

```bash
# Check memory usage
heroku ps

# Upgrade dyno if needed
heroku ps:type web=standard-1x
```

### Slow Performance

```bash
# Enable query logging
heroku config:set RAILS_LOG_LEVEL=debug

# Check slow queries in logs
heroku logs --tail | grep "Completed.*ms"

# Add database indexes (in migration)
# Consider upgrading database plan
heroku addons:upgrade postgresql:standard-0
```

## CI/CD with GitHub Actions

The repository includes a GitHub Actions workflow for Heroku deployment.

### Setup GitHub Secrets

Add these secrets to your GitHub repository:

1. `HEROKU_API_KEY` - Your Heroku API key (get from: heroku auth:token)
2. `HEROKU_APP_NAME` - Your Heroku app name
3. `HEROKU_EMAIL` - Your Heroku account email

### Workflow Configuration

The workflow in `.github/workflows/deploy.yml` handles:
- Building and testing
- Deploying to Heroku
- Running migrations
- Health checks

## Environment Variables Reference

### Required

| Variable | Description | How to Get |
|----------|-------------|------------|
| `DATABASE_URL` | PostgreSQL connection URL | Auto-set by Heroku |
| `SECRET_KEY_BASE` | Rails secret key | `rails secret` |

### Optional

| Variable | Description | Default |
|----------|-------------|---------|
| `RAILS_MASTER_KEY` | Encrypted credentials key | From `config/master.key` |
| `RAILS_LOG_TO_STDOUT` | Log to stdout | `enabled` |
| `RAILS_SERVE_STATIC_FILES` | Serve static assets | `enabled` |
| `GOOGLE_ANALYTICS_ID` | Google Analytics tracking | None |
| `FACEBOOK_PIXEL_ID` | Facebook Pixel tracking | None |
| `REDIS_URL` | Redis connection (if using Redis addon) | Auto-set |

## Cost Optimization

### Free Tier Limitations

- App sleeps after 30 minutes of inactivity
- Limited to 1,000 free dyno hours/month
- Basic PostgreSQL: 10,000 rows max, no backups

### Recommended Upgrades

1. **Hobby Dynos** ($7/month): Never sleeps, better performance
2. **Standard Postgres** ($50/month): Unlimited rows, automated backups
3. **Redis** (if needed): For caching and background jobs

## Backup Strategy

### Manual Backups

```bash
# Capture backup
heroku pg:backups:capture

# Download backup
heroku pg:backups:download

# List backups
heroku pg:backups
```

### Automated Backups

```bash
# Add backup addon (requires paid plan)
heroku addons:create heroku-postgresql:standard-0

# Backups run automatically daily
# Verify schedule
heroku pg:backups:schedules
```

## Performance Tips

1. **Use CDN**: Configure `config.asset_host` with CloudFront or Cloudflare
2. **Enable Caching**: Add Redis for fragment caching
3. **Add Indexes**: Add database indexes for frequently queried columns
4. **Optimize Images**: Use Active Storage with image processing
5. **Monitor Performance**: Use Heroku metrics or New Relic

## Security Checklist

- [ ] Changed default admin password
- [ ] Set strong `SECRET_KEY_BASE`
- [ ] Enabled SSL (automatic on Heroku)
- [ ] Configured `RAILS_MASTER_KEY` if using credentials
- [ ] Set up monitoring/error tracking (Sentry, Rollbar)
- [ ] Enabled automated backups
- [ ] Configured custom domain with SSL
- [ ] Set up two-factor authentication on Heroku account

## Common Commands Cheat Sheet

```bash
# Deployment
git push heroku main                    # Deploy to Heroku
heroku releases                         # View deployment history
heroku rollback                         # Rollback to previous version

# Database
heroku run rails db:migrate             # Run migrations
heroku run rails db:seed                # Seed database
heroku run rails console                # Rails console
heroku pg:psql                          # Database console

# Monitoring
heroku logs --tail                      # View live logs
heroku ps                               # Check dyno status
heroku config                           # View environment variables

# Management
heroku restart                          # Restart all dynos
heroku maintenance:on                   # Enable maintenance mode
heroku maintenance:off                  # Disable maintenance mode
```

## Getting Help

- **Heroku Docs**: https://devcenter.heroku.com/articles/getting-started-with-rails8
- **Application Logs**: `heroku logs --tail`
- **Heroku Status**: https://status.heroku.com
- **Support**: https://help.heroku.com

## Additional Resources

- [Heroku Rails Documentation](https://devcenter.heroku.com/categories/ruby-support)
- [Heroku Postgres Guide](https://devcenter.heroku.com/articles/heroku-postgresql)
- [Deploying with Git](https://devcenter.heroku.com/articles/git)
- [Heroku CLI Reference](https://devcenter.heroku.com/articles/heroku-cli-commands)

---

For other deployment options, see [DEVOPS.md](DEVOPS.md)
