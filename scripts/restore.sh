#!/bin/bash
# Database Restore Script
# Usage: ./scripts/restore.sh <backup_file>

set -e

BACKUP_FILE="$1"
CONTAINER_NAME="cms-db-1"

if [ -z "$BACKUP_FILE" ]; then
    echo "❌ Error: No backup file specified"
    echo "Usage: ./scripts/restore.sh <backup_file>"
    echo "Available backups:"
    ls -lh ./backups/
    exit 1
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "⚠️  WARNING: This will overwrite the current database!"
read -p "Are you sure you want to restore from ${BACKUP_FILE}? (yes/no): " -r
echo

if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    echo "❌ Restore cancelled"
    exit 1
fi

echo "🔄 Restoring database from ${BACKUP_FILE}..."

# Decompress if needed
if [[ $BACKUP_FILE == *.gz ]]; then
    echo "📦 Decompressing backup..."
    gunzip -c "$BACKUP_FILE" | docker exec -i ${CONTAINER_NAME} psql -U postgres cms_production
else
    docker exec -i ${CONTAINER_NAME} psql -U postgres cms_production < "$BACKUP_FILE"
fi

echo "✅ Database restored successfully!"
