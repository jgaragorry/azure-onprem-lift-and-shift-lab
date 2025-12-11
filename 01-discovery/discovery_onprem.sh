#!/usr/bin/env bash
set -euo pipefail

OUTPUT_FILE="discovery_onprem_$(hostname)_$(date +%Y%m%d_%H%M%S).txt"

echo "[01-discovery] Iniciando análisis del servidor On-Prem..."
echo "Archivo de salida: ${OUTPUT_FILE}"
echo

{
  echo "===== DISCOVERY ON-PREM ====="
  echo "Fecha: $(date)"
  echo "Host:  $(hostname)"
  echo

  echo "== Sistema =="
  hostnamectl
  echo

  echo "== CPU y Memoria =="
  echo "--- CPU ---"
  lscpu | egrep 'Model name|CPU\(s\)|Thread|Core'
  echo
  echo "--- RAM ---"
  free -h
  echo

  echo "== Disco (df -h) =="
  df -h
  echo

  echo "== Tamaño de directorios en /var/www (si existen) =="
  sudo du -sh /var/www/* 2>/dev/null || true
  echo

  echo "== Puertos y servicios (ss -tulpn) =="
  sudo ss -tulpn
  echo

  echo "== Procesos top CPU =="
  ps aux --sort=-%cpu | head -n 10
  echo

  echo "== Procesos top MEM =="
  ps aux --sort=-%mem | head -n 10
  echo

  echo "===== FIN DEL DISCOVERY ====="
} | tee "${OUTPUT_FILE}"

echo "[01-discovery] Discovery completado correctamente."
echo "Archivo generado: ${OUTPUT_FILE}"

