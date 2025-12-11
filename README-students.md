# 🧑‍🎓 Student Guide – Azure On-Prem Lift & Shift Migration Lab  

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Bash](https://img.shields.io/badge/Bash%20Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Networking](https://img.shields.io/badge/Networking-005A9C?style=for-the-badge&logo=cisco&logoColor=white)
![rsync](https://img.shields.io/badge/rsync-0A66C2?style=for-the-badge&logo=files&logoColor=white)
![SSH](https://img.shields.io/badge/SSH-2C2D72?style=for-the-badge&logo=gnu-privacy-guard&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-007ACC?style=for-the-badge&logo=azuredevops&logoColor=white)
![FinOps](https://img.shields.io/badge/FinOps-00A98F?style=for-the-badge&logo=googlecloud&logoColor=white)

Bienvenido al laboratorio completo de **Migración Lift & Shift On-Prem → Azure**, diseñado para que aprendas paso a paso cómo realizar una migración real, usando herramientas profesionales y un enfoque de DevOps + FinOps.

Este documento está orientado específicamente para **estudiantes**, con explicaciones claras, pasos guiados y recomendaciones para evitar errores.

---

# 🎯 Objetivos del Estudiante

Al finalizar este laboratorio serás capaz de:

- Construir un servidor On-Prem Linux desde cero.
- Analizarlo con un Discovery profesional.
- Crear infraestructura en Azure usando Azure CLI.
- Migrar un sitio completo con **rsync + SSH**.
- Validar la migración con herramientas Linux.
- Realizar cleanup para evitar costos (FinOps).
- Explicar en entrevistas cómo se estructura una migración real.

---

# 📂 Estructura del laboratorio

El proyecto está dividido en fases claras:

```
00-onprem/      → Creación del servidor origen
01-discovery/   → Discovery & Assessment
02-cloud/       → Infraestructura Azure
03-migration/   → Migración con rsync
04-validation/  → Validación del servicio en Azure
05-cleanup/     → Eliminación de recursos (FinOps)
docs/           → Documentación técnica y conceptual
```

---

# 🧱 Pre-requisitos para estudiantes

Antes de comenzar asegúrate de tener:

- Conocimientos básicos de Linux.
- Azure CLI instalado.
- Cuenta activa en Azure (free tier es suficiente).
- Una VM local con Ubuntu Server.
- Claves SSH funcionales.
- Editor como VSCode.

---

# 🚀 Flujo del laboratorio

## 1️⃣ Fase 00 – Crear servidor On-Prem

Ejecuta:

```bash
cd 00-onprem
chmod +x setup_onprem_vm.sh
./setup_onprem_vm.sh
```

Validación:

```bash
curl http://localhost
```

---

## 2️⃣ Fase 01 – Discovery & Assessment

Ejecuta:

```bash
cd 01-discovery
chmod +x discovery_onprem.sh
./discovery_onprem.sh
```

Revisa el archivo `.txt` generado con información del servidor.

---

## 3️⃣ Fase 02 – Crear infraestructura Azure

Configura tus variables:

```bash
cd 02-cloud/azure
cp set_env_example.sh set_env.sh
nano set_env.sh
```

Ejecuta:

```bash
chmod +x create_azure_infra.sh
./create_azure_infra.sh
```

Al final verás:

```
IP Pública: xxx.xxx.xxx.xxx
```

---

## 4️⃣ Fase 03 – Migración con rsync

Ejecuta:

```bash
cd 03-migration/rsync
chmod +x migrate_rsync.sh
./migrate_rsync.sh azureuser <IP_PUBLICA>
```

---

## 5️⃣ Fase 04 – Validación

Ejecuta:

```bash
cd 04-validation
chmod +x validate_migration.sh
./validate_migration.sh azureuser <IP_PUBLICA>
```

---

## 6️⃣ Fase 05 – Cleanup

Ejecuta:

```bash
cd 05-cleanup
chmod +x cleanup_azure.sh
./cleanup_azure.sh
```

---

# 🧠 Conceptos Clave para Aprender

- Lift & Shift (Rehost)
- VNet, Subnet, NSG
- Right-Sizing (FinOps)
- rsync incremental
- SSH Keys & Seguridad
- Infraestructura como Código (Azure CLI)
- Validación de servicios Linux
- Eliminación de recursos para evitar costos

---

# 🆘 Consejos para no cometer errores

- No olvides ejecutar `az login` antes de crear infra.
- La VM On-Prem debe tener Apache habilitado.
- Usa siempre la IP pública que muestra el script.
- Revisa permisos de tu clave SSH si falla la conexión.
- Siempre ejecuta `cleanup` al terminar.

---

# 📬 Contacto del Autor

- LinkedIn: https://www.linkedin.com/in/jgaragorry/
- GitHub: https://github.com/jgaragorry/
- TikTok: https://www.tiktok.com/@softtraincorp
- Instagram: https://www.instagram.com/stclatam/
- Comunidad WhatsApp: https://chat.whatsapp.com/ENuRMnZ38fv1pk0mHlSixa

---

# ✔ Fin del README para Estudiantes

