#!/bin/bash
# Production Deployment Script using Docker Compose
# Usage: ./scripts/deploy.sh [environment]

set -e

ENVIRONMENT="${1:-production}"
COMPOSE_FILE="docker-compose.prod.yml"

echo "🚀 Deploying to ${ENVIRONMENT}..."

# Check if .env.production exists
if [ ! -f .env.production ]; then
    echo "❌ Error: .env.production file not found"
    echo "Please copy .env.production.example to .env.production and configure it"
    exit 1
fi

# Load environment variables
export $(cat .env.production | grep -v '^#' | xargs)

echo "📦 Building Docker images..."
docker-compose -f ${COMPOSE_FILE} build --no-cache

echo "🔄 Stopping existing containers..."
docker-compose -f ${COMPOSE_FILE} down

echo "📂 Creating volumes..."
docker-compose -f ${COMPOSE_FILE} up -d db redis

echo "⏳ Waiting for database to be ready..."
sleep 10

echo "🗄️  Running database migrations..."
docker-compose -f ${COMPOSE_FILE} run --rm web rails db:create db:migrate

echo "🌱 Loading seed data (if needed)..."
# Uncomment the next line if you want to seed data on deploy
# docker-compose -f ${COMPOSE_FILE} run --rm web rails db:seed

echo "🎨 Precompiling assets..."
docker-compose -f ${COMPOSE_FILE} run --rm web rails assets:precompile

echo "🚀 Starting all services..."
docker-compose -f ${COMPOSE_FILE} up -d

echo "🧹 Cleaning up old images..."
docker image prune -f

echo "✅ Deployment complete!"
echo "🔍 Check application health: curl http://localhost:3000/health"
echo "📊 View logs: docker-compose -f ${COMPOSE_FILE} logs -f web"
