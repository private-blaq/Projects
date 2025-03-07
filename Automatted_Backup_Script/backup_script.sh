#!/bin/bash

# 📂 The folder that needs to be backed up
BACKUP_SOURCE="/home/dreamline/Documents"

# 📌 Where to store the backups
BACKUP_DEST="/home/dreamline/backups"

# 🏷️ Backup file name (includes date and time)
BACKUP_NAME="backup_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# 🔥 Keep backups for 7 days, delete older ones
RETENTION_DAYS=7

# 🛠️ Make sure the backup folder exists
mkdir -p "$BACKUP_DEST"

# 📦 Create the compressed backup file
tar -czf "$BACKUP_DEST/$BACKUP_NAME" "$BACKUP_SOURCE"

# 🗑️ Delete backups older than 7 days
find "$BACKUP_DEST" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

# ✅ Print a success message
echo "✅ Backup completed: $BACKUP_NAME"
