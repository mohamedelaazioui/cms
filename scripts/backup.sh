#!/bin/bash
# Database Backup Script
# Usage: ./scripts/backup.sh [backup_name]

set -e

BACKUP_NAME="${1:-backup_$(date +%Y%m%d_%H%M%S)}"
BACKUP_DIR="./backups"
CONTAINER_NAME="cms-db-1"

# Create backup directory if it doesn't exist
mkdir -p ${BACKUP_DIR}

echo "📦 Creating database backup: ${BACKUP_NAME}"

# Backup PostgreSQL database
docker exec ${CONTAINER_NAME} pg_dump -U postgres cms_production > "${BACKUP_DIR}/${BACKUP_NAME}.sql"

# Compress the backup
gzip "${BACKUP_DIR}/${BACKUP_NAME}.sql"

echo "✅ Backup created: ${BACKUP_DIR}/${BACKUP_NAME}.sql.gz"

# Keep only last 7 backups
echo "🧹 Cleaning old backups..."
cd ${BACKUP_DIR}
ls -t *.sql.gz | tail -n +8 | xargs -r rm --

echo "✅ Backup complete!"
