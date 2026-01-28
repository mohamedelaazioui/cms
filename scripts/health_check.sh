#!/bin/bash
# Health Check Script
# Usage: ./scripts/health_check.sh [url]

set -e

URL="${1:-http://localhost:3000}"

echo "🔍 Checking application health..."

# Check main health endpoint
response=$(curl -s -o /dev/null -w "%{http_code}" "${URL}/health")

if [ "$response" = "200" ]; then
    echo "✅ Health check passed (HTTP $response)"
    
    # Get detailed health info
    health_data=$(curl -s "${URL}/health")
    echo "📊 Health Details:"
    echo "$health_data" | jq '.' || echo "$health_data"
    
    exit 0
else
    echo "❌ Health check failed (HTTP $response)"
    exit 1
fi
