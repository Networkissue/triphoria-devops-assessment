#!/bin/bash

set -e

CONTAINER="triphoria-postgres"
DB_NAME="triphoria"
DB_USER="admin"

BACKUP_DIR="../backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="triphoria_${TIMESTAMP}.dump"

mkdir -p "$BACKUP_DIR"

echo "Creating backup..."

# Disable Git Bash path conversion
export MSYS_NO_PATHCONV=1

# Create dump inside the container
docker exec "$CONTAINER" \
pg_dump \
-U "$DB_USER" \
-d "$DB_NAME" \
-F c \
-f "/tmp/$BACKUP_FILE"

# Copy dump to the host
docker cp "$CONTAINER:/tmp/$BACKUP_FILE" \
"$BACKUP_DIR/$BACKUP_FILE"

# Remove temporary dump from the container
docker exec "$CONTAINER" rm -f "/tmp/$BACKUP_FILE"

echo ""
echo "Backup completed successfully."
echo "Backup saved to:"
echo "$BACKUP_DIR/$BACKUP_FILE"

echo ""
echo "Backup size:"
ls -lh "$BACKUP_DIR/$BACKUP_FILE"