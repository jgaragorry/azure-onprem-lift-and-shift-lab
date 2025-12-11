#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Uso: $0 <usuario_azure> <ip_publica_azure>"
  echo "Ejemplo: $0 azureuser 20.88.42.100"
  exit 1
fi

AZ_USER="$1"
AZ_IP="$2"

echo "======================================================="
echo "[04-validation] Validación On-Prem → Azure"
echo "======================================================="

echo "[INFO] Usuario Azure: ${AZ_USER}"
echo "[INFO] IP Pública Azure: ${AZ_IP}"
echo

echo "-------------------------------------------------------"
echo "[1/4] Validación desde tu máquina (curl local)..."
echo "-------------------------------------------------------"
curl -s "http://${AZ_IP}" | head -n 10 || echo "[WARN] No se pudo obtener respuesta externa."
echo

echo "-------------------------------------------------------"
echo "[2/4] Validación dentro de la VM Azure (curl localhost)..."
echo "-------------------------------------------------------"
ssh "${AZ_USER}@${AZ_IP}" "echo 'URL interna:' && curl -s http://localhost | head -n 10"
echo

echo "-------------------------------------------------------"
echo "[3/4] Comparando archivos On-Prem vs Azure..."
echo "-------------------------------------------------------"

echo "== Archivos On-Prem =="
sudo find /var/www/html -maxdepth 2 -type f | sort

echo
echo "== Archivos Azure =="
ssh "${AZ_USER}@${AZ_IP}" "sudo find /var/www/html -maxdepth 2 -type f | sort"
echo

echo "-------------------------------------------------------"
echo "[4/4] Verificando estado de Apache en Azure..."
echo "-------------------------------------------------------"
ssh "${AZ_USER}@${AZ_IP}" "sudo systemctl status apache2 --no-pager || true"
echo

echo "======================================================="
echo "[04-validation] Validación completada correctamente."
echo "======================================================="

