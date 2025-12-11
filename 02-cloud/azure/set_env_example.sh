#!/usr/bin/env bash

# COPIAR ESTE ARCHIVO COMO set_env.sh Y EDITAR LOS VALORES

# Resource Group
export LAB_RG="rg-mig-lab"
export LAB_LOCATION="eastus"

# Red
export LAB_VNET="vnet-mig-lab"
export LAB_VNET_CIDR="10.10.0.0/16"
export LAB_SUBNET="snet-app"
export LAB_SUBNET_CIDR="10.10.1.0/24"

# Seguridad
export LAB_NSG="nsg-mig-lab"

# VM destino en Azure
export LAB_VM_NAME="vm-mig-azure"
export LAB_VM_SIZE="Standard_B1s"
export LAB_ADMIN_USER="azureuser"

# Etiquetas FinOps
export LAB_TAG_ENV="lab"
export LAB_TAG_PROJECT="onprem-migration"
export LAB_TAG_OWNER="jgaragorry"

