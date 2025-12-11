#!/usr/bin/env bash
set -euo pipefail

echo "==============================================="
echo "[05-cleanup] Eliminación de Infraestructura Azure"
echo "==============================================="

# Cargar variables desde set_env.sh
if [[ -f "../02-cloud/azure/set_env.sh" ]]; then
  source ../02-cloud/azure/set_env.sh
elif [[ -f "./set_env.sh" ]]; then
  source ./set_env.sh
else
  echo "[ERROR] No se encontró el archivo set_env.sh."
  echo "Debe estar en:"
  echo " - 02-cloud/azure/set_env.sh"
  echo "O en este directorio."
  exit 1
fi

echo "[INFO] Resource Group a eliminar: ${LAB_RG}"
echo

read -r -p "¿Estás seguro que deseas ELIMINAR el Resource Group ${LAB_RG}? (yes/no): " CONFIRM

if [[ "${CONFIRM}" != "yes" ]]; then
  echo "[05-cleanup] Operación cancelada por el usuario."
  exit 0
fi

echo "[05-cleanup] Enviando solicitud de eliminación..."
az group delete \
  --name "${LAB_RG}" \
  --yes \
  --no-wait

echo
echo "-----------------------------------------------"
echo "[05-cleanup] Eliminación iniciada."
echo "Puedes verificar en 30–60 segundos con:"
echo "az group show -n ${LAB_RG}"
echo "-----------------------------------------------"

