#!/bin/bash
# Rollback Script
# Usage: ./scripts/rollback.sh

set -e

COMPOSE_FILE="docker-compose.prod.yml"

echo "⚠️  Rolling back to previous version..."

# Get the previous image tag
PREVIOUS_IMAGE=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep cms | sed -n '2p')

if [ -z "$PREVIOUS_IMAGE" ]; then
    echo "❌ Error: No previous image found"
    exit 1
fi

echo "📦 Rolling back to: ${PREVIOUS_IMAGE}"

# Update docker-compose to use previous image
docker-compose -f ${COMPOSE_FILE} down
docker-compose -f ${COMPOSE_FILE} up -d

echo "✅ Rollback complete!"
echo "🔍 Check application health: ./scripts/health_check.sh"
