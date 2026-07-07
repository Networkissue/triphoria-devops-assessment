#!/bin/bash

set -e

CONTAINER="triphoria-postgres"
DB_NAME="triphoria"
DB_USER="admin"
BACKUP_DIR="../backups"

# Use latest backup if none is provided
if [ $# -eq 0 ]; then
    BACKUP_FILE=$(ls -t "$BACKUP_DIR"/*.dump 2>/dev/null | head -n 1)

    if [ -z "$BACKUP_FILE" ]; then
        echo "No backup files found in $BACKUP_DIR"
        exit 1
    fi

    echo "No backup file specified."
    echo "Using latest backup: $BACKUP_FILE"
else
    BACKUP_FILE="$1"
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Backup file not found: $BACKUP_FILE"
    exit 1
fi

echo "Copying backup into container..."

MSYS_NO_PATHCONV=1 docker cp "$BACKUP_FILE" "$CONTAINER:/var/lib/postgresql/restore.dump"

echo "Dropping existing database..."

docker exec "$CONTAINER" psql -U "$DB_USER" -d postgres \
-c "DROP DATABASE IF EXISTS $DB_NAME;"

echo "Creating fresh database..."

docker exec "$CONTAINER" psql -U "$DB_USER" -d postgres \
-c "CREATE DATABASE $DB_NAME;"

echo "Restoring database..."

docker exec "$CONTAINER" sh -c \
"pg_restore -U $DB_USER -d $DB_NAME --clean --if-exists /var/lib/postgresql/restore.dump"

echo "Cleaning up..."

docker exec "$CONTAINER" rm -f /var/lib/postgresql/restore.dump

echo ""
echo "Restore completed successfully."
echo ""

echo "Verifying restore..."

docker exec "$CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" \
-c "SELECT COUNT(*) AS hotel_bookings FROM hotel_bookings;"

docker exec "$CONTAINER" psql -U "$DB_USER" -d "$DB_NAME" \
-c "SELECT COUNT(*) AS booking_events FROM booking_events;"