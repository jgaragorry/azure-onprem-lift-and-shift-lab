#!/usr/bin/env bash
set -euo pipefail

echo "========================================="
echo "[00-onprem] Preparando servidor On-Prem (simulado)"
echo "========================================="

if ! command -v apt >/dev/null 2>&1; then
  echo "[WARN] Este script está diseñado para sistemas basados en Debian/Ubuntu."
fi

DOC_ROOT="/var/www/html"
INDEX_FILE="${DOC_ROOT}/index.html"

echo "[00-onprem] Actualizando paquetes..."
sudo apt update -y
sudo apt upgrade -y

echo "[00-onprem] Instalando Apache..."
sudo apt install -y apache2

echo "[00-onprem] Habilitando y arrancando Apache..."
sudo systemctl enable apache2
sudo systemctl restart apache2

echo "[00-onprem] Preparando directorio web..."
sudo mkdir -p "${DOC_ROOT}"

echo "[00-onprem] Creando página HTML de ejemplo..."
sudo bash -c "cat > '${INDEX_FILE}' <<'EOF'
<!DOCTYPE html>
<html lang=\"es\">
  <head>
    <meta charset=\"UTF-8\">
    <title>Servidor On-Prem (Simulado)</title>
  </head>
  <body>
    <h1>Servidor On-Prem (Simulado)</h1>
    <p>Este servidor será migrado a Azure mediante Lift & Shift.</p>
  </body>
</html>
EOF"

echo "[00-onprem] Reiniciando Apache..."
sudo systemctl restart apache2

echo "[00-onprem] Validando con curl..."
if command -v curl >/dev/null 2>&1; then
  curl -s http://localhost | head -n 10
else
  echo "[WARN] curl no está instalado. Puedes instalarlo con:"
  echo "sudo apt install -y curl"
fi

echo "========================================="
echo "[00-onprem] Servidor On-Prem listo."
echo "Accede a http://localhost"
echo "========================================="

