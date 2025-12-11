#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Uso: $0 <usuario_azure> <ip_publica_azure>"
  echo "Ejemplo: $0 azureuser 20.88.42.100"
  exit 1
fi

AZ_USER="$1"
AZ_IP="$2"

SOURCE_DIR="/var/www/"
TARGET_DIR="/var/www/"

echo "==============================================="
echo "[03-migration] Iniciando migración On-Prem → Azure"
echo "==============================================="
echo "[INFO] Usuario Azure: ${AZ_USER}"
echo "[INFO] IP Pública Azure: ${AZ_IP}"
echo

echo "[03-migration] Verificando acceso SSH a la VM Azure..."
ssh -o StrictHostKeyChecking=accept-new "${AZ_USER}@${AZ_IP}" "echo 'Conexión SSH OK en Azure'"

echo "[03-migration] Instalando Apache en la VM Azure (si no existe)..."
ssh "${AZ_USER}@${AZ_IP}" "sudo apt update && sudo apt install -y apache2 && sudo systemctl enable apache2 && sudo systemctl restart apache2"

echo "[03-migration] Ejecutando rsync..."
sudo rsync -avz \
  "${SOURCE_DIR}" \
  "${AZ_USER}@${AZ_IP}:${TARGET_DIR}"

echo "[03-migration] Reiniciando Apache en Azure..."
ssh "${AZ_USER}@${AZ_IP}" "sudo systemctl restart apache2 && sudo systemctl status apache2 --no-pager"

echo "==============================================="
echo "[03-migration] Migración completada correctamente."
echo "Probar con:"
echo "curl http://${AZ_IP}"
echo "==============================================="

