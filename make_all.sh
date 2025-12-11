#!/usr/bin/env bash
set -euo pipefail

# --------------------------------------------------
# Azure On-Prem Lift & Shift – Master Script
# --------------------------------------------------

# Detectar ruta raíz del repo
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${ROOT_DIR}"

# Directorio de logs
mkdir -p "${ROOT_DIR}/logs"
LOG_FILE="${ROOT_DIR}/logs/run_$(date +%Y%m%d_%H%M%S).log"

# Logs en tiempo real (pantalla + archivo)
exec > >(tee -a "${LOG_FILE}") 2>&1

# Colores
GREEN="\e[32m"
BLUE="\e[34m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"
BOLD="\e[1m"
ENDCOLOR="\e[0m"

SILENT=0
FLAG_ALL=0
FLAG_CLEANUP_ONLY=0

# --------------------------------------------------
# Funciones auxiliares
# --------------------------------------------------

banner() {
  [[ "${SILENT}" -eq 1 ]] && return 0
  echo -e "${CYAN}"
  echo "   ___              _                ___                        _ "
  echo "  / _ \__ _ _ _  __| |___ _ _ ___   / _ \ _ _  ___ _ _ ___ _ _ (_)"
  echo " |  _/ _\` | ' \/ _\` / -_) '_/ -_) | (_) | ' \/ -_) '_/ -_) ' \| |"
  echo " |_| \__,_|_||_\__,_\___|_| \___|  \___/|_||_\___|_| \___|_||_|_|"
  echo
  echo "      Azure On-Prem Lift & Shift – Master Orchestrator"
  echo -e "${ENDCOLOR}"
}

usage() {
  cat <<EOF
Uso: $(basename "$0") [opciones]

Opciones:
  --all            Ejecuta todas las fases (00 → 05) en pipeline
  --cleanup-only   Ejecuta solo la fase 05 (cleanup de Azure)
  --silent         Modo silencioso (menos mensajes meta)
  --help           Muestra esta ayuda

Sin flags, se mostrará un menú interactivo.
EOF
}

log_info() {
  [[ "${SILENT}" -eq 1 ]] && return 0
  echo -e "${GREEN}[INFO]${ENDCOLOR} $*"
}

log_warn() {
  echo -e "${YELLOW}[WARN]${ENDCOLOR} $*"
}

log_error() {
  echo -e "${RED}[ERROR]${ENDCOLOR} $*"
}

require_az_login() {
  if ! command -v az >/dev/null 2>&1; then
    log_error "Azure CLI (az) no está instalado en esta máquina."
    exit 1
  fi

  if ! az account show >/dev/null 2>&1; then
    log_warn "No estás autenticado en Azure. Ejecutando az login..."
    az login
  fi
}

run_phase() {
  local phase_name="$1"
  local cmd="$2"

  log_info "Ejecutando ${phase_name}..."
  if ! bash -c "${cmd}"; then
    log_error "Fallo en ${phase_name}. Revisar el log: ${LOG_FILE}"
    exit 1
  fi
  log_info "✔ ${phase_name} completada."
  echo
}

ask_azure_connection_data() {
  # Permite usar variables ya definidas, o pedirlas al usuario
  if [[ -z "${AZ_USER:-}" ]]; then
    read -rp "Usuario Azure (por ej. azureuser): " AZ_USER
  fi
  if [[ -z "${AZ_IP:-}" ]]; then
    read -rp "IP Pública de la VM Azure: " AZ_IP
  fi
}

# --------------------------------------------------
# Parseo de flags
# --------------------------------------------------
while [[ $# -gt 0 ]]; do
  case "$1" in
    --all)
      FLAG_ALL=1
      shift
      ;;
    --cleanup-only)
      FLAG_CLEANUP_ONLY=1
      shift
      ;;
    --silent)
      SILENT=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      log_warn "Flag desconocida: $1"
      usage
      exit 1
      ;;
  esac
done

banner
log_info "Log de esta ejecución: ${LOG_FILE}"
echo

# --------------------------------------------------
# Acciones rápidas por flags
# --------------------------------------------------

if [[ "${FLAG_CLEANUP_ONLY}" -eq 1 ]]; then
  require_az_login
  run_phase "Fase 05 – Cleanup (solo)" "cd '${ROOT_DIR}/05-cleanup' && chmod +x cleanup_azure.sh && ./cleanup_azure.sh"
  exit 0
fi

if [[ "${FLAG_ALL}" -eq 1 ]]; then
  require_az_login

  # Fase 00 – On-Prem
  run_phase "Fase 00 – On-Prem Setup" "cd '${ROOT_DIR}/00-onprem' && chmod +x setup_onprem_vm.sh && ./setup_onprem_vm.sh"

  # Fase 01 – Discovery
  run_phase "Fase 01 – Discovery" "cd '${ROOT_DIR}/01-discovery' && chmod +x discovery_onprem.sh && ./discovery_onprem.sh"

  # Fase 02 – Azure Infra
  run_phase "Fase 02 – Infraestructura Azure" "cd '${ROOT_DIR}/02-cloud/azure' && chmod +x create_azure_infra.sh && ./create_azure_infra.sh"

  # Pedir datos para conexión Azure
  ask_azure_connection_data

  # Fase 03 – Migración rsync
  run_phase "Fase 03 – Migración rsync" "cd '${ROOT_DIR}/03-migration/rsync' && chmod +x migrate_rsync.sh && ./migrate_rsync.sh '${AZ_USER}' '${AZ_IP}'"

  # Fase 04 – Validación
  run_phase "Fase 04 – Validación" "cd '${ROOT_DIR}/04-validation' && chmod +x validate_migration.sh && ./validate_migration.sh '${AZ_USER}' '${AZ_IP}'"

  # Fase 05 – Cleanup
  run_phase "Fase 05 – Cleanup" "cd '${ROOT_DIR}/05-cleanup' && chmod +x cleanup_azure.sh && ./cleanup_azure.sh"

  log_info "Pipeline completo ejecutado con éxito (00 → 05)."
  exit 0
fi

# --------------------------------------------------
# Menú interactivo si no hay flags
# --------------------------------------------------

require_az_login

echo
log_info "Seleccione una acción:"
echo "1) Fase 00 – On-Prem Setup"
echo "2) Fase 01 – Discovery"
echo "3) Fase 02 – Infraestructura Azure"
echo "4) Fase 03 – Migración rsync"
echo "5) Fase 04 – Validación"
echo "6) Fase 05 – Cleanup"
echo "7) Ejecutar TODO el laboratorio (00 → 05)"
echo "0) Salir"
echo
read -rp "Opción: " OPT

case "${OPT}" in
  1)
    run_phase "Fase 00 – On-Prem Setup" "cd '${ROOT_DIR}/00-onprem' && chmod +x setup_onprem_vm.sh && ./setup_onprem_vm.sh"
    ;;
  2)
    run_phase "Fase 01 – Discovery" "cd '${ROOT_DIR}/01-discovery' && chmod +x discovery_onprem.sh && ./discovery_onprem.sh"
    ;;
  3)
    run_phase "Fase 02 – Infraestructura Azure" "cd '${ROOT_DIR}/02-cloud/azure' && chmod +x create_azure_infra.sh && ./create_azure_infra.sh"
    ;;
  4)
    ask_azure_connection_data
    run_phase "Fase 03 – Migración rsync" "cd '${ROOT_DIR}/03-migration/rsync' && chmod +x migrate_rsync.sh && ./migrate_rsync.sh '${AZ_USER}' '${AZ_IP}'"
    ;;
  5)
    ask_azure_connection_data
    run_phase "Fase 04 – Validación" "cd '${ROOT_DIR}/04-validation' && chmod +x validate_migration.sh && ./validate_migration.sh '${AZ_USER}' '${AZ_IP}'"
    ;;
  6)
    run_phase "Fase 05 – Cleanup" "cd '${ROOT_DIR}/05-cleanup' && chmod +x cleanup_azure.sh && ./cleanup_azure.sh"
    ;;
  7)
    # Pipeline desde menú
    run_phase "Fase 00 – On-Prem Setup" "cd '${ROOT_DIR}/00-onprem' && chmod +x setup_onprem_vm.sh && ./setup_onprem_vm.sh"
    run_phase "Fase 01 – Discovery" "cd '${ROOT_DIR}/01-discovery' && chmod +x discovery_onprem.sh && ./discovery_onprem.sh"
    run_phase "Fase 02 – Infraestructura Azure" "cd '${ROOT_DIR}/02-cloud/azure' && chmod +x create_azure_infra.sh && ./create_azure_infra.sh"
    ask_azure_connection_data
    run_phase "Fase 03 – Migración rsync" "cd '${ROOT_DIR}/03-migration/rsync' && chmod +x migrate_rsync.sh && ./migrate_rsync.sh '${AZ_USER}' '${AZ_IP}'"
    run_phase "Fase 04 – Validación" "cd '${ROOT_DIR}/04-validation' && chmod +x validate_migration.sh && ./validate_migration.sh '${AZ_USER}' '${AZ_IP}'"
    run_phase "Fase 05 – Cleanup" "cd '${ROOT_DIR}/05-cleanup' && chmod +x cleanup_azure.sh && ./cleanup_azure.sh"
    ;;
  0)
    log_info "Salida del script."
    exit 0
    ;;
  *)
    log_error "Opción inválida."
    exit 1
    ;;
esac

