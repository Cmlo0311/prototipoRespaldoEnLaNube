#!/bin/bash

verificar_dependencias() {
  for cmd in rclone find; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "[ERROR] Comando requerido no encontrado: $cmd"
      exit 1
    fi
  done
}
