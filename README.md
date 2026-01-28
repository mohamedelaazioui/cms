# CMS - Bilingual Content Management System

A fully functional, production-ready Content Management System built with Ruby on Rails 8, featuring bilingual support (English/Japanese), comprehensive DevOps automation, and modern web technologies.

## ✨ Features

### Content Management
- **Admin Dashboard**: Comprehensive admin panel to manage all content
- **Pages Management**: Create and manage static pages with rich text editor
- **Services Management**: Showcase educational services with descriptions and icons
- **Testimonials**: Display customer testimonials with carousel animations
- **Social Links**: Manage social media presence (Facebook, Instagram, YouTube)
- **Contact Form**: Allow visitors to send messages with GDPR consent

### Internationalization (i18n)
- **Bilingual Support**: Full English and Japanese translations
- **Language Switcher**: Easy toggle between languages in navbar
- **Locale-Specific Content**: Separate database records for EN/JA content
- **SEO-Optimized**: Language-specific meta tags and canonical URLs

### SEO & Analytics
- **Meta Tags**: Dynamic title, description, keywords, and canonical URLs
- **Open Graph**: Full social media integration (Facebook, Twitter)
- **JSON-LD**: Structured data for search engines
- **Google Analytics 4**: Comprehensive traffic tracking
- **Facebook Pixel**: Conversion tracking and remarketing
- **GDPR Cookie Banner**: Compliant cookie consent management

### DevOps & Production Ready
- **Docker Support**: Full containerization for dev and production
- **CI/CD Pipeline**: GitHub Actions for automated testing and deployment
- **Health Checks**: Kubernetes-compatible health, ready, and liveness probes
- **Nginx Configuration**: Production-ready reverse proxy with SSL support
- **Database Backups**: Automated backup and restore scripts
- **Monitoring**: Application health monitoring and logging

### Security
- **Devise Authentication**: Secure admin authentication
- **RuboCop Linting**: Code quality and security enforcement
- **Brakeman**: Security vulnerability scanning
- **Bundle Audit**: Dependency vulnerability checks
- **Security Headers**: X-Frame-Options, CSP, XSS Protection

### Performance
- **Asset Precompilation**: Optimized static assets
- **Redis Caching**: Fast caching and background jobs
- **Gzip Compression**: Reduced bandwidth usage
- **CDN-Ready**: Static file serving optimization

## 🚀 Quick Start

### Docker (Recommended)

```bash
# Clone the repository
git clone <repository-url>
cd cms

# Start development environment
docker-compose up

# In another terminal, setup database
docker-compose exec web rails db:create db:migrate db:seed

# Visit http://localhost:3000
```

### Local Development

```bash
# Clone the repository
git clone <repository-url>
cd cms

# Install dependencies
bundle install
yarn install

# Setup database
rails db:create db:migrate db:seed

# Start server
rails server

# Visit http://localhost:3000
```

## 🔐 Admin Access

After running `db:seed`, you can log in to the admin panel:

- **URL**: http://localhost:3000/admins/sign_in
- **Email**: admin@example.com
- **Password**: password123

⚠️ **Important**: Change these credentials in production!

## 🐳 Production Deployment

### Quick Deploy to Heroku

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Or manually:

```bash
# Login to Heroku
heroku login

# Create app
heroku create your-app-name

# Add PostgreSQL
heroku addons:create heroku-postgresql:essential-0

# Deploy
git push heroku main

# Setup database
heroku run rails db:migrate db:seed
```

See [HEROKU.md](HEROKU.md) for complete Heroku deployment guide.

### Using Docker Compose

```bash
# Copy production environment template
cp .env.production.example .env.production

# Edit .env.production with your production values
nano .env.production

# Deploy
./scripts/deploy.sh production

# Check health
./scripts/health_check.sh http://your-domain.com
```

### Using Kamal

```bash
# Setup Kamal deployment
kamal setup

# Deploy
kamal deploy
```

See [DEVOPS.md](DEVOPS.md) for comprehensive deployment documentation.

## 📋 Available Scripts

- `./scripts/deploy.sh` - Deploy to production
- `./scripts/backup.sh` - Create database backup
- `./scripts/restore.sh` - Restore from backup
- `./scripts/health_check.sh` - Check application health
- `./scripts/logs.sh` - View application logs
- `./scripts/rollback.sh` - Rollback to previous version

## 🌐 Health Check Endpoints

The application provides health check endpoints for monitoring:

- `/health` - Comprehensive health check (database, Redis)
- `/health/ready` - Readiness probe
- `/health/live` - Liveness probe

```bash
curl http://localhost:3000/health
```

## 🧪 Testing

```bash
# Run all tests
rails test

# Run system tests
rails test:system

# Run security scans
bundle exec brakeman
bundle exec rubocop
```

## 🔧 Tech Stack

### Backend
- Ruby on Rails 8.0.4
- PostgreSQL 16
- Redis 7
- Devise (Authentication)
- FriendlyId (SEO-friendly URLs)

### Frontend
- Bootstrap 5.3
- Stimulus.js
- Turbo
- Font Awesome 6.5.1

### DevOps
- Docker & Docker Compose
- GitHub Actions CI/CD
- Nginx (Reverse Proxy)
- Kamal (Deployment)

### Monitoring & Analytics
- Google Analytics 4
- Facebook Pixel
- Sentry (Optional)
- New Relic (Optional)

## 📁 Project Structure

```
app/
├── controllers/
│   ├── admin/              # Admin controllers
│   ├── application_controller.rb  # Locale switching
│   ├── health_controller.rb       # Health checks
│   └── public_controller.rb       # Public pages
├── models/
│   ├── service.rb          # Locale-specific services
│   ├── testimonial.rb      # Locale-specific testimonials
│   └── ...
├── views/
│   ├── admin/              # Admin panel views
│   ├── public/             # Bilingual public views
│   └── layouts/            # SEO-optimized layouts
└── helpers/
    └── application_helper.rb  # SEO & i18n helpers

config/
├── locales/                # EN/JA translations
│   ├── en.yml
│   └── ja.yml
├── initializers/
│   └── tracking.rb         # Analytics configuration
└── routes.rb               # Locale-scoped routes

docker/
├── Dockerfile              # Production image
├── Dockerfile.dev          # Development image
├── docker-compose.yml      # Development setup
└── docker-compose.prod.yml # Production setup

.github/
└── workflows/
    ├── ci.yml              # CI pipeline
    └── deploy.yml          # CD pipeline

scripts/
├── deploy.sh               # Deployment script
├── backup.sh               # Database backup
├── restore.sh              # Database restore
├── health_check.sh         # Health monitoring
├── logs.sh                 # Log viewing
└── rollback.sh             # Rollback deployment
```

## 🌍 Internationalization

### Adding Translations

Edit locale files in `config/locales/`:

```yaml
# config/locales/en.yml
en:
  site:
    name: "My CMS"
    tagline: "Your tagline here"
```

### Creating Locale-Specific Content

```ruby
# Create English service
Service.create!(
  title: "English Lessons",
  description: "...",
  locale: "en"
)

# Create Japanese service
Service.create!(
  title: "英語レッスン",
  description: "...",
  locale: "ja"
)
```

## ⚙️ Configuration

### Environment Variables

Create a `.env` file based on `.env.example`:

```bash
# Database
DB_HOST=localhost
DB_USERNAME=postgres
DB_PASSWORD=postgres

# Analytics (Optional)
GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
FACEBOOK_PIXEL_ID=123456789012345

# Rails
SECRET_KEY_BASE=your_secret_key
RAILS_MASTER_KEY=your_master_key
```

See `.env.example` for all available options.

## 🔒 Security

### Production Checklist

- [ ] Change default admin credentials
- [ ] Set strong `SECRET_KEY_BASE` and `RAILS_MASTER_KEY`
- [ ] Enable SSL/TLS (HTTPS)
- [ ] Configure firewall rules
- [ ] Set up automated backups
- [ ] Enable error tracking (Sentry)
- [ ] Review and update dependencies regularly
- [ ] Configure CORS if needed
- [ ] Set up rate limiting
- [ ] Enable security headers in Nginx

## 📊 Monitoring

### Application Logs

```bash
# View logs
./scripts/logs.sh web follow

# Check specific service
docker-compose logs -f db
docker-compose logs -f redis
```

### Performance Monitoring

Monitor application health:
- `/health` endpoint for overall health
- Redis memory usage
- Database connection pool
- Response times

## 🆘 Troubleshooting

See [DEVOPS.md](DEVOPS.md) for comprehensive troubleshooting guide.

Common issues:

### Database Connection Failed
```bash
# Check database status
docker-compose exec db pg_isready

# Restart database
docker-compose restart db
```

### Assets Not Loading
```bash
# Precompile assets
rails assets:precompile

# Or in Docker
docker-compose run --rm web rails assets:precompile
```

## 📚 Documentation

- [DevOps Guide](DEVOPS.md) - Comprehensive deployment and operations documentation
- [Docker Setup](docker-setup.sh) - Automated Docker setup script
- [API Health Checks](#-health-check-endpoints) - Health check endpoint documentation

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Quality

Ensure code passes all checks:
```bash
bundle exec rubocop
bundle exec brakeman
rails test
```

## 📄 License

This project is available as open source under the MIT License.

## 🙏 Acknowledgments

- Ruby on Rails team
- Bootstrap team
- Font Awesome
- All open source contributors

---

**For deployment and DevOps documentation, see [DEVOPS.md](DEVOPS.md)**
