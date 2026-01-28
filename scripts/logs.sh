#!/bin/bash
# Log Viewing Script
# Usage: ./scripts/logs.sh [service] [follow]

set -e

SERVICE="${1:-web}"
FOLLOW="${2:-false}"
COMPOSE_FILE="docker-compose.prod.yml"

echo "📋 Viewing logs for service: ${SERVICE}"

if [ "$FOLLOW" = "follow" ] || [ "$FOLLOW" = "-f" ]; then
    docker-compose -f ${COMPOSE_FILE} logs -f --tail=100 ${SERVICE}
else
    docker-compose -f ${COMPOSE_FILE} logs --tail=100 ${SERVICE}
fi
