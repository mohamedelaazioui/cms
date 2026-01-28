#!/bin/bash
# Docker Setup and Run Script for CMS Application

set -e

echo "🐳 CMS Docker Setup"
echo "===================="
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "❌ Docker is not running. Please start Docker Desktop and try again."
  exit 1
fi

echo "✅ Docker is running"
echo ""

# Build images
echo "📦 Building Docker images..."
docker-compose build

echo ""
echo "🗄️  Setting up database..."
docker-compose run --rm web rails db:create db:migrate db:seed

echo ""
echo "✅ Setup complete!"
echo ""
echo "To start the application, run:"
echo "  docker-compose up"
echo ""
echo "Or to run in detached mode:"
echo "  docker-compose up -d"
echo ""
echo "The application will be available at: http://localhost:3000"
echo "Admin login: admin@example.com / password123"
