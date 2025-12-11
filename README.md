# Azure On-Prem Lift & Shift Migration Lab  

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Bash](https://img.shields.io/badge/Bash%20Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure%20CLI-0089D6?style=for-the-badge&logo=microsoftazure&logoColor=white)
![rsync](https://img.shields.io/badge/rsync-0A66C2?style=for-the-badge&logo=files&logoColor=white)
![SSH](https://img.shields.io/badge/SSH-2C2D72?style=for-the-badge&logo=gnu-privacy-guard&logoColor=white)
![Networking](https://img.shields.io/badge/Networking-005A9C?style=for-the-badge&logo=cisco&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-007ACC?style=for-the-badge&logo=azuredevops&logoColor=white)
![FinOps](https://img.shields.io/badge/FinOps-00A98F?style=for-the-badge&logo=googlecloud&logoColor=white)

---

# 📌 Descripción General

Este laboratorio reproduce un caso **completo y realista** de migración **On-Prem → Azure** utilizando:

- rsync + SSH  
- Azure CLI como IaC (Infraestructura como Código)  
- Buenas prácticas DevOps  
- Principios FinOps (optimización de costos)  
- Documentación profesional al nivel de consultoras como DXC, Accenture, EY, NTT, Kyndryl  

Esta es una pieza de portafolio **lista para mostrar a reclutadores** y perfecta para enseñar migraciones reales.

---

# 🧱 Arquitectura del Laboratorio

```
On-Prem (VM local)
    |
    | rsync + SSH
    v
Azure VM (Destino)
```

Componentes Azure creados por script:

- Resource Group  
- VNet + Subnet  
- NSG (reglas 22 y 80)  
- NIC  
- IP Pública  
- VM Ubuntu 24.04 LTS (SKU B1s)  
- Etiquetas FinOps  

---

# 🧰 Tecnologías utilizadas

- Linux (Ubuntu 24.04)  
- Apache Web Server  
- rsync  
- SSH Keys  
- Azure CLI  
- Azure Virtual Machines  
- Azure Networking (VNet, NSG, IPs)  
- Bash scripting  
- Modelos de migración Cloud (6 Rs)  
- FinOps (Right-sizing + cleanup)  

---

# 📂 Estructura del Repositorio

```
azure-onprem-lift-and-shift-lab/
├── 00-onprem/
│   ├── README.md
│   └── setup_onprem_vm.sh
├── 01-discovery/
│   ├── README.md
│   └── discovery_onprem.sh
├── 02-cloud/
│   └── azure/
│       ├── README.md
│       ├── create_azure_infra.sh
│       ├── set_env_example.sh
│       └── ssh_config_notes.md
├── 03-migration/
│   └── rsync/
│       ├── README.md
│       └── migrate_rsync.sh
├── 04-validation/
│   ├── README.md
│   └── validate_migration.sh
├── 05-cleanup/
│   ├── README.md
│   └── cleanup_azure.sh
├── docs/
│   ├── architecture-diagram-mermaid.md
│   ├── concepts-migration-models.md
│   ├── finops-best-practices.md
│   └── interview-questions-migrations.md
└── make_all.sh   ← Script maestro de automatización
```

---

# ✨ Automatización con `make_all.sh`

Este repositorio incluye un script maestro de orquestación llamado:

```
make_all.sh
```

Su objetivo es facilitar:

- La ejecución de **fases individuales** (00, 01, 02, 03, 04, 05).  
- La ejecución de **todo el pipeline** de laboratorio en orden (00 → 05).  
- La ejecución **solo del cleanup** para evitar costos en Azure.  
- El registro de **logs en tiempo real** en la carpeta `logs/`.  
- Un **modo silencioso** para reducir ruido en pantalla durante demos.

## 🔧 Flags disponibles

```
--all            Ejecuta todo el laboratorio 00→05
--cleanup-only   Ejecuta únicamente la fase de eliminación
--silent         Reduce el ruido visual
--help           Muestra ayuda
```

## 📌 Ejemplos de uso

### Menú interactivo (modo normal)

```bash
./make_all.sh
```

### Ejecutar TODO el laboratorio (00 → 05)

```bash
./make_all.sh --all
```

### Ejecutar solo cleanup (evitar cobros en Azure)

```bash
./make_all.sh --cleanup-only
```

### Pipeline completo + menos ruido

```bash
./make_all.sh --all --silent
```

## 📝 Logs en tiempo real

Cada ejecución genera un log en:

```
logs/run_YYYYMMDD_HHMMSS.log
```

Esto te permite:

- Revisar fallos  
- Demostrar pipeline en entrevistas  
- Guardar evidencia de ejecución  

---

# 🔄 Flujo Completo del Laboratorio (Fase por Fase)

A continuación tienes el flujo completo con todos los detalles, como en la versión penúltima, pero con el refinamiento profesional y badges del README final.

---

# 1️⃣ Fase 00 — Preparación del Servidor On-Prem

📌 Objetivos:

- Simular un servidor On-Prem con Apache.  
- Crear `/var/www/html` con contenido identificable.  
- Instalar servicios vía script automatizado.  

📁 Archivos clave:

```
00-onprem/setup_onprem_vm.sh
```

📌 Comando:

```bash
./setup_onprem_vm.sh
```

Resultado esperado:

- Apache activo  
- Página publicada en `http://localhost`  

---

# 2️⃣ Fase 01 — Discovery & Assessment

📌 Objetivo profesional:

Recolectar información del servidor On-Prem:

- CPU, RAM, arquitectura  
- Uso de disco  
- Puertos abiertos  
- Servicios  
- Tamaño de la aplicación  
- Procesos de consumo  

📁 Archivos:

```
01-discovery/discovery_onprem.sh
```

📌 Comando:

```bash
./discovery_onprem.sh
```

Genera:

```
discovery_onprem_<host>_<fecha>.txt
```

---

# 3️⃣ Fase 02 — Creación Infraestructura Azure

📌 Objetivo:

Crear la infraestructura destino en Azure:

- RG  
- VNet  
- Subnet  
- NSG  
- IP Pública  
- NIC  
- VM Ubuntu 24.04  
- Tags FinOps  

📁 Archivos:

```
02-cloud/azure/set_env_example.sh
02-cloud/azure/create_azure_infra.sh
```

📌 Ejecución:

```bash
cp set_env_example.sh set_env.sh
./create_azure_infra.sh
```

Resultado:

- VM creada  
- IP pública lista  
- SSH habilitado  

---

# 4️⃣ Fase 03 — Migración con rsync

📌 Objetivo:

- Transferir contenido real On-Prem → Azure.  
- Mantener permisos, estructura, archivos, timestamp.  

📁 Archivos:

```
03-migration/rsync/migrate_rsync.sh
```

📌 Ejecución:

```bash
./migrate_rsync.sh azureuser <IP_AZURE>
```

---

# 5️⃣ Fase 04 — Validación de la Migración

📌 Objetivo:

Validar que:

- Apache funciona en Azure  
- Estructura de archivos es idéntica  
- Respuestas HTTP correctas  
- Puerto 80 expuesto  

📁 Archivo:

```
04-validation/validate_migration.sh
```

📌 Comando:

```bash
./validate_migration.sh azureuser <IP_AZURE>
```

---

# 6️⃣ Fase 05 — Cleanup (FinOps)

📌 Objetivo:

Eliminar todos los recursos Azure para evitar costos.

📁 Archivo:

```
05-cleanup/cleanup_azure.sh
```

📌 Comando:

```bash
./cleanup_azure.sh
```

---

# 🧠 Documentación Técnica Incluida (docs/)

- **Modelos de Migración (6 R’s)**  
- **Diagrama de arquitectura en Mermaid**  
- **Buenas prácticas FinOps**  
- **Preguntas típicas de entrevistas**  

---

# ⭐ Valor Profesional del Proyecto

✔ Migraciones On-Prem → Cloud  
✔ Azure Networking  
✔ Azure Compute  
✔ Linux SysAdmin  
✔ Automatización con Bash  
✔ Infraestructura como Código (Azure CLI)  
✔ Buenas prácticas DevOps + FinOps  
✔ Documentación profesional empresarial  

Perfecto para:

- LinkedIn  
- Portafolio GitHub  
- Entrevistas técnicas  
- Demostraciones con clientes  

---

# 📬 Contacto del Autor

- LinkedIn: https://www.linkedin.com/in/jgaragorry/  
- GitHub: https://github.com/jgaragorry/  
- TikTok: https://www.tiktok.com/@softtraincorp  
- Instagram: https://www.instagram.com/stclatam/  
- Comunidad WhatsApp: https://chat.whatsapp.com/ENuRMnZ38fv1pk0mHlSixa  

---

# ✔ Estado del Proyecto

**Completado, documentado y validado.**  
Listo para producción, portafolio o docencia.

