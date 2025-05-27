#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Ruta base
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuración
source "$SCRIPT_DIR/config/respaldo.conf"

# Validaciones de variables
: "${BASE:?BASE no definida}"
: "${REMOTE:?REMOTE no definido}"
: "${TRASH_ROOT:?TRASH_ROOT no definido}"
: "${EXCLUDE_FILE:?EXCLUDE_FILE no definido}"
: "${TRANSFERS:?TRANSFERS no definido}"
: "${CHECKERS:?CHECKERS no definido}"
: "${BWLIMIT:?BWLIMIT no definido}"
: "${RETENTION_DAYS:?RETENTION_DAYS no definido}"

# Logging
LOG_FILE="${LOG_FILE:-$SCRIPT_DIR/logs/respaldo.log}"
mkdir -p "$(dirname "$LOG_FILE")"
exec > >(tee -a "$LOG_FILE") 2>&1

# Lock
LOCK_FILE="${LOCK_FILE:-/tmp/respaldo_master.lock}"
if [[ -e "$LOCK_FILE" ]]; then
  echo "[ERROR] Ya hay una instancia en ejecución."
  exit 1
fi
trap 'rm -f "$LOCK_FILE"; exit' INT TERM EXIT
> "$LOCK_FILE"

echo "========== Iniciando respaldo: $(date) =========="

# Incluir funciones
source "$SCRIPT_DIR/funciones/utils.sh"
source "$SCRIPT_DIR/funciones/organizacion.sh"
source "$SCRIPT_DIR/funciones/sincronizacion.sh"
source "$SCRIPT_DIR/funciones/purga.sh"

verificar_dependencias
organizar_archivos
sincronizar_con_respaldo
purga_papeleras_antiguas

rm -f "$LOCK_FILE"
trap - INT TERM EXIT
echo "========== Finalizado: $(date) =========="
