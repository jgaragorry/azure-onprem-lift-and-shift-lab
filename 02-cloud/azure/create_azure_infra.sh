#!/usr/bin/env bash
set -euo pipefail

# Cargar variables
if [[ -f "./set_env.sh" ]]; then
  source ./set_env.sh
else
  echo "[ERROR] Falta set_env.sh (crea una copia desde set_env_example.sh)"
  exit 1
fi

echo "=========================================="
echo "[02-cloud] Creando infraestructura en Azure"
echo "=========================================="

echo "[02-cloud] 1) Creando Resource Group..."
az group create \
  --name "${LAB_RG}" \
  --location "${LAB_LOCATION}"

echo "[02-cloud] 2) Creando VNet y Subnet..."
az network vnet create \
  --resource-group "${LAB_RG}" \
  --name "${LAB_VNET}" \
  --address-prefixes "${LAB_VNET_CIDR}" \
  --subnet-name "${LAB_SUBNET}" \
  --subnet-prefixes "${LAB_SUBNET_CIDR}"

echo "[02-cloud] 3) Creando NSG..."
az network nsg create \
  --resource-group "${LAB_RG}" \
  --name "${LAB_NSG}"

echo "[02-cloud] 4) Agregando reglas de NSG..."

# SSH
az network nsg rule create \
  --resource-group "${LAB_RG}" \
  --nsg-name "${LAB_NSG}" \
  --name "Allow-SSH" \
  --priority 1000 \
  --protocol Tcp \
  --direction Inbound \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-port-ranges 22 \
  --access Allow

# HTTP
az network nsg rule create \
  --resource-group "${LAB_RG}" \
  --nsg-name "${LAB_NSG}" \
  --name "Allow-HTTP" \
  --priority 1010 \
  --protocol Tcp \
  --direction Inbound \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-port-ranges 80 \
  --access Allow

echo "[02-cloud] 5) Creando IP pública..."
az network public-ip create \
  --resource-group "${LAB_RG}" \
  --name "pip-${LAB_VM_NAME}" \
  --sku Basic \
  --allocation-method Dynamic

echo "[02-cloud] 6) Creando NIC..."
az network nic create \
  --resource-group "${LAB_RG}" \
  --name "nic-${LAB_VM_NAME}" \
  --vnet-name "${LAB_VNET}" \
  --subnet "${LAB_SUBNET}" \
  --network-security-group "${LAB_NSG}" \
  --public-ip-address "pip-${LAB_VM_NAME}"

echo "[02-cloud] 7) Creando VM Linux Ubuntu..."
az vm create \
  --resource-group "${LAB_RG}" \
  --name "${LAB_VM_NAME}" \
  --image Ubuntu2404 \
  --size "${LAB_VM_SIZE}" \
  --admin-username "${LAB_ADMIN_USER}" \
  --nics "nic-${LAB_VM_NAME}" \
  --generate-ssh-keys \
  --tags env="${LAB_TAG_ENV}" project="${LAB_TAG_PROJECT}" owner="${LAB_TAG_OWNER}"

echo "[02-cloud] 8) Obteniendo IP pública..."
PUBLIC_IP=$(az vm show -d -g "${LAB_RG}" -n "${LAB_VM_NAME}" --query publicIps -o tsv)

echo "=========================================="
echo "[02-cloud] VM creada exitosamente."
echo "IP Pública: ${PUBLIC_IP}"
echo "Conéctate usando:"
echo "ssh ${LAB_ADMIN_USER}@${PUBLIC_IP}"
echo "=========================================="

