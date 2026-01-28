# DevOps Documentation

## 🚀 Deployment Guide

This project is fully containerized and ready for production deployment with comprehensive DevOps automation.

### Prerequisites

- Docker and Docker Compose installed
- PostgreSQL 16+ (or use Docker Compose)
- Redis 7+ (or use Docker Compose)
- Ruby 3.3.8 (for local development)

### Quick Start - Production Deployment

1. **Clone the repository**
```bash
git clone <repository-url>
cd cms
```

2. **Configure environment variables**
```bash
cp .env.production.example .env.production
# Edit .env.production with your production values
```

3. **Deploy using the deployment script**
```bash
./scripts/deploy.sh production
```

4. **Verify deployment**
```bash
./scripts/health_check.sh http://your-domain.com
```

---

## 📋 Available Scripts

All scripts are located in the `scripts/` directory:

### Deployment
```bash
./scripts/deploy.sh [environment]
# Builds and deploys the application to production
```

### Database Backup
```bash
./scripts/backup.sh [backup_name]
# Creates a compressed database backup
# Backups are stored in ./backups/
# Automatically keeps only the last 7 backups
```

### Database Restore
```bash
./scripts/restore.sh <backup_file>
# Restores database from a backup file
# Example: ./scripts/restore.sh ./backups/backup_20260128.sql.gz
```

### Health Checks
```bash
./scripts/health_check.sh [url]
# Checks application health endpoints
# Default: http://localhost:3000
```

### View Logs
```bash
./scripts/logs.sh [service] [follow]
# View logs for a specific service
# Examples:
#   ./scripts/logs.sh web          # Last 100 lines
#   ./scripts/logs.sh web follow   # Follow logs in real-time
```

### Rollback
```bash
./scripts/rollback.sh
# Rolls back to the previous Docker image
```

---

## 🏥 Health Check Endpoints

The application provides three health check endpoints for monitoring:

### `/health` - Comprehensive Health Check
Returns overall application health including database and Redis status.

```bash
curl http://localhost:3000/health
```

Response:
```json
{
  "status": "healthy",
  "timestamp": "2026-01-28T10:00:00Z",
  "services": {
    "database": "up",
    "redis": "up"
  },
  "version": "1.0.0"
}
```

### `/health/ready` - Readiness Probe
Checks if the application is ready to serve requests (Kubernetes readiness probe).

```bash
curl http://localhost:3000/health/ready
```

### `/health/live` - Liveness Probe
Checks if the application is alive (Kubernetes liveness probe).

```bash
curl http://localhost:3000/health/live
```

---

## 🐳 Docker Configuration

### Development
```bash
# Start development environment
docker-compose up

# Run in background
docker-compose up -d

# View logs
docker-compose logs -f web

# Stop services
docker-compose down
```

### Production
```bash
# Start production environment
docker-compose -f docker-compose.prod.yml up -d

# Scale web service
docker-compose -f docker-compose.prod.yml up -d --scale web=3

# View resource usage
docker stats
```

---

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

#### **CI Workflow** (`.github/workflows/ci.yml`)
Runs on every push and pull request:
- ✅ RuboCop linting
- ✅ Security scans (Brakeman, ImportMap audit)
- ✅ Test suite
- ✅ System tests
- ✅ Docker image build

#### **Deploy Workflow** (`.github/workflows/deploy.yml`)
Deploys to production on main branch pushes:
- Uses Kamal for zero-downtime deployments
- Requires GitHub Secrets configuration

### Required GitHub Secrets

Configure these in your repository settings (Settings → Secrets → Actions):

```
RAILS_MASTER_KEY           # From config/master.key
SECRET_KEY_BASE            # Generate with: rails secret
SSH_PRIVATE_KEY            # SSH key for deployment server
DEPLOY_HOST                # Your server IP or domain
KAMAL_REGISTRY_PASSWORD    # Docker registry password
```

---

## 🔐 Environment Variables

### Required for Production

| Variable | Description | Example |
|----------|-------------|---------|
| `SECRET_KEY_BASE` | Rails secret key | Generate with `rails secret` |
| `RAILS_MASTER_KEY` | Master encryption key | From `config/master.key` |
| `DB_HOST` | Database host | `db` or `postgres.example.com` |
| `DB_USERNAME` | Database username | `postgres` |
| `DB_PASSWORD` | Database password | Strong password |
| `DB_NAME` | Database name | `cms_production` |
| `REDIS_URL` | Redis connection URL | `redis://redis:6379/0` |
| `APP_DOMAIN` | Production domain | `your-domain.com` |

### Optional Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `GOOGLE_ANALYTICS_ID` | Google Analytics tracking ID | None |
| `FACEBOOK_PIXEL_ID` | Facebook Pixel ID | None |
| `GOOGLE_TAG_MANAGER_ID` | GTM container ID | None |
| `SENTRY_DSN` | Sentry error tracking DSN | None |
| `PORT` | Application port | `3000` |
| `APP_VERSION` | Application version | `1.0.0` |

See `.env.production.example` for the complete list.

---

## 🌐 Nginx Configuration

The application includes production-ready Nginx configuration with:

- ✅ Static file serving with 1-year cache
- ✅ Gzip compression
- ✅ Rate limiting
- ✅ Security headers (X-Frame-Options, CSP, etc.)
- ✅ Health check endpoint
- ✅ SSL/TLS configuration (commented, ready to enable)
- ✅ Custom error pages

### Enabling SSL/TLS

1. Obtain SSL certificates (e.g., Let's Encrypt)
2. Place certificates in `nginx/ssl/`:
   - `fullchain.pem`
   - `privkey.pem`
3. Uncomment the HTTPS server block in `nginx/nginx.conf`
4. Restart Nginx: `docker-compose -f docker-compose.prod.yml restart nginx`

---

## 📊 Monitoring & Logging

### Application Logs
```bash
# View all logs
./scripts/logs.sh web follow

# View specific service logs
docker-compose -f docker-compose.prod.yml logs -f db
docker-compose -f docker-compose.prod.yml logs -f redis
docker-compose -f docker-compose.prod.yml logs -f nginx
```

### Log Levels
Configure via `RAILS_LOG_LEVEL` environment variable:
- `debug` - Development
- `info` - Production (default)
- `warn` - Only warnings and errors
- `error` - Only errors

### External Monitoring (Optional)

The application supports integration with:
- **Sentry** - Error tracking
- **New Relic** - Application performance monitoring
- **Google Analytics** - Website analytics
- **Facebook Pixel** - Conversion tracking

Configure via environment variables in `.env.production`.

---

## 🔄 Database Management

### Migrations
```bash
# Run migrations in production
docker-compose -f docker-compose.prod.yml run --rm web rails db:migrate

# Check migration status
docker-compose -f docker-compose.prod.yml run --rm web rails db:migrate:status

# Rollback last migration
docker-compose -f docker-compose.prod.yml run --rm web rails db:rollback
```

### Backups
```bash
# Create backup
./scripts/backup.sh

# Create named backup
./scripts/backup.sh prod_backup_20260128

# List backups
ls -lh backups/

# Restore backup
./scripts/restore.sh backups/backup_20260128.sql.gz
```

### Database Console
```bash
# PostgreSQL console
docker-compose -f docker-compose.prod.yml exec db psql -U postgres cms_production

# Rails console
docker-compose -f docker-compose.prod.yml run --rm web rails console
```

---

## 🚨 Troubleshooting

### Application Won't Start

1. Check logs:
```bash
./scripts/logs.sh web
```

2. Verify environment variables:
```bash
docker-compose -f docker-compose.prod.yml config
```

3. Check database connection:
```bash
docker-compose -f docker-compose.prod.yml exec db pg_isready
```

### Health Check Fails

```bash
# Check detailed health status
curl http://localhost:3000/health | jq

# Check database connectivity
docker-compose -f docker-compose.prod.yml exec db psql -U postgres -c "SELECT 1"

# Check Redis connectivity
docker-compose -f docker-compose.prod.yml exec redis redis-cli ping
```

### High Memory Usage

```bash
# Check resource usage
docker stats

# Scale down services
docker-compose -f docker-compose.prod.yml up -d --scale web=1

# Restart services
docker-compose -f docker-compose.prod.yml restart
```

### Database Performance Issues

```bash
# Check database size
docker-compose -f docker-compose.prod.yml exec db psql -U postgres -c "SELECT pg_size_pretty(pg_database_size('cms_production'))"

# Run VACUUM
docker-compose -f docker-compose.prod.yml exec db psql -U postgres cms_production -c "VACUUM ANALYZE"
```

---

## 🔒 Security Best Practices

1. **Never commit secrets** - Use `.env` files (already in `.gitignore`)
2. **Rotate credentials regularly** - Update database passwords, secret keys
3. **Keep dependencies updated** - Run `bundle update` and `yarn upgrade`
4. **Enable SSL/TLS** - Always use HTTPS in production
5. **Monitor security advisories** - Check GitHub Dependabot alerts
6. **Regular backups** - Schedule automated backups (cron job recommended)
7. **Limit access** - Use firewall rules and security groups

### Running Security Scans

```bash
# RuboCop linting
bundle exec rubocop

# Brakeman security scan
bundle exec brakeman

# Bundle audit (check for vulnerable gems)
bundle audit --update
```

---

## 📈 Performance Optimization

### Asset Precompilation
```bash
# Precompile assets in production
docker-compose -f docker-compose.prod.yml run --rm web rails assets:precompile
```

### Database Connection Pool
Adjust `RAILS_MAX_THREADS` in `.env.production` based on your workload.

### Redis Caching
The application uses Redis for caching and background jobs. Monitor Redis memory:
```bash
docker-compose -f docker-compose.prod.yml exec redis redis-cli info memory
```

---

## 📝 Maintenance Tasks

### Regular Maintenance Checklist

- [ ] Weekly database backups
- [ ] Monthly dependency updates
- [ ] Quarterly security audits
- [ ] Review application logs for errors
- [ ] Monitor disk space usage
- [ ] Check SSL certificate expiration
- [ ] Review and rotate access credentials

### Dependency Updates

```bash
# Update Ruby gems
bundle update

# Update JavaScript packages
yarn upgrade

# Rebuild Docker images
docker-compose -f docker-compose.prod.yml build --no-cache
```

---

## 🆘 Support & Contact

For deployment issues or questions:
1. Check the troubleshooting section above
2. Review application logs
3. Check GitHub Issues for similar problems
4. Contact the development team

---

## 📄 License & Credits

- Built with Ruby on Rails 8.0.4
- PostgreSQL 16
- Redis 7
- Bootstrap 5.3
- Docker & Docker Compose
