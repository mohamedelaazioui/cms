# Docker Setup for CMS Application

This Rails CMS application is fully dockerized for easy development and deployment.

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running
- At least 4GB of RAM allocated to Docker

## Quick Start

### Option 1: Using the setup script (Recommended)

```bash
# Make the script executable
chmod +x docker-setup.sh

# Run setup
./docker-setup.sh

# Start the application
docker-compose up
```

### Option 2: Manual setup

```bash
# Build images
docker-compose build

# Create and setup database
docker-compose run --rm web rails db:create db:migrate db:seed

# Start all services
docker-compose up
```

## Access the Application

- **Web Application**: http://localhost:3000
- **Admin Panel**: http://localhost:3000/admin/admins/sign_in
  - Email: `admin@example.com`
  - Password: `password123`

## Docker Services

The docker-compose.yml defines three services:

1. **web** - Rails application (port 3000)
2. **db** - PostgreSQL database (port 5432)
3. **redis** - Redis for caching (port 6379)

## Common Commands

### Start services
```bash
# Foreground (see logs)
docker-compose up

# Background (detached)
docker-compose up -d
```

### Stop services
```bash
docker-compose down
```

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f web
```

### Run Rails commands
```bash
# Rails console
docker-compose run --rm web rails console

# Run migrations
docker-compose run --rm web rails db:migrate

# Reset database
docker-compose run --rm web rails db:reset

# Run tests
docker-compose run --rm web rails test
```

### Access Rails console
```bash
docker-compose run --rm web rails console
```

### Access database directly
```bash
docker-compose exec db psql -U postgres -d cms_development
```

### Rebuild containers
```bash
# Rebuild all
docker-compose build

# Rebuild specific service
docker-compose build web

# Rebuild without cache
docker-compose build --no-cache
```

### Clean up
```bash
# Stop and remove containers, networks
docker-compose down

# Also remove volumes (⚠️ deletes database data)
docker-compose down -v

# Remove all unused Docker resources
docker system prune -a
```

## Environment Variables

Create a `.env` file in the project root for custom configuration:

```env
# Database
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=cms_development

# Rails
RAILS_ENV=development
RAILS_MAX_THREADS=5

# Analytics (optional)
GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
FACEBOOK_PIXEL_ID=123456789012345
```

## Development with Docker

### Hot reloading
The application code is mounted as a volume, so changes are reflected immediately without rebuilding.

### Installing new gems
```bash
# Add gem to Gemfile, then:
docker-compose run --rm web bundle install
docker-compose restart web
```

### Installing new npm packages
```bash
# Add package to package.json, then:
docker-compose run --rm web yarn install
docker-compose restart web
```

## Production Deployment

For production, use the main `Dockerfile`:

```bash
# Build production image
docker build -t cms:latest .

# Run production container
docker run -d \
  -p 80:80 \
  -e RAILS_MASTER_KEY=<your-master-key> \
  -e DATABASE_URL=<your-database-url> \
  --name cms-production \
  cms:latest
```

Or use with [Kamal](https://kamal-deploy.org/) for deployment to any server.

## Troubleshooting

### Port already in use
```bash
# Find process using port 3000
lsof -ti:3000

# Kill the process
kill -9 <PID>
```

### Database connection issues
```bash
# Ensure database is healthy
docker-compose ps

# Restart database
docker-compose restart db

# Check database logs
docker-compose logs db
```

### Permission issues
```bash
# Fix file permissions
sudo chown -R $USER:$USER .
```

### Clean slate restart
```bash
# Stop everything
docker-compose down -v

# Remove all images
docker-compose rm -f

# Rebuild and start fresh
docker-compose build --no-cache
docker-compose up
```

## File Structure

```
.
├── Dockerfile              # Production Dockerfile
├── Dockerfile.dev          # Development Dockerfile
├── docker-compose.yml      # Docker Compose configuration
├── .dockerignore          # Files to exclude from Docker build
└── docker-setup.sh        # Quick setup script
```

## Performance Tips

1. **Use volumes for gems**: Speeds up rebuilds by caching gems
2. **Allocate more RAM**: Go to Docker Desktop → Settings → Resources
3. **Use BuildKit**: Enable in Docker Desktop settings for faster builds
4. **Clean up regularly**: Run `docker system prune` to free up space

## Support

For issues or questions:
- Check Docker logs: `docker-compose logs`
- Verify services are running: `docker-compose ps`
- Restart services: `docker-compose restart`
- Check Rails logs: `docker-compose exec web tail -f log/development.log`
