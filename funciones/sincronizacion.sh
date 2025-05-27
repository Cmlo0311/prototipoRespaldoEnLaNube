#!/bin/bash

sincronizar_con_respaldo() {
  echo "-> Sincronizando $BASE -> $REMOTE"
  TIMESTAMP=$(date +%Y%m%d_%H%M%S)
  BACKUP_DIR="$TRASH_ROOT/backup_$TIMESTAMP"
  rclone mkdir "$TRASH_ROOT" 2>/dev/null || true
  rclone sync "$BASE" "$REMOTE" \
    --backup-dir "$BACKUP_DIR" \
    --exclude-from "$EXCLUDE_FILE" \
    --transfers "$TRANSFERS" \
    --checkers "$CHECKERS" \
    --bwlimit "$BWLIMIT" \
    --progress
  echo "-> Sincronización completada: $TIMESTAMP"
}
