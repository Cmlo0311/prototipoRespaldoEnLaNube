#!/bin/bash

purga_papeleras_antiguas() {
  echo "-> Purga de papeleras con más de $RETENTION_DAYS días"
  rclone lsf "$TRASH_ROOT" --dirs-only | while read -r dir; do
    ts=${dir#backup_}
    date_dir=${ts%%_*}
    if [[ "$(date -d "$date_dir" +%s)" -le "$(date -d "-$RETENTION_DAYS days" +%s)" ]]; then
      echo "   Borrando papelera: $dir"
      rclone purge "$TRASH_ROOT/$dir"
    fi
  done
  echo "-> Purga completada"
}
