# 🧑‍🏫 Instructor Guide – Azure On-Prem Lift & Shift Migration Lab  

![Azure](https://img.shields.io/badge/Azure-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![Bash](https://img.shields.io/badge/Bash%20Scripting-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![DevOps](https://img.shields.io/badge/DevOps-007ACC?style=for-the-badge&logo=azuredevops&logoColor=white)
![FinOps](https://img.shields.io/badge/FinOps-00A98F?style=for-the-badge&logo=googlecloud&logoColor=white)
![Networking](https://img.shields.io/badge/Azure%20Networking-0089D6?style=for-the-badge&logo=microsoftazure&logoColor=white)

Este documento está diseñado para instructores, coaches, capacitadores y líderes técnicos que impartirán el laboratorio de migración **On-Prem → Azure**.

Contiene lineamientos pedagógicos, objetivos de enseñanza, pautas de evaluación y recomendaciones para gestionar el ritmo y la complejidad del aprendizaje.

---

# 🎯 Objetivos del Instructor

Al finalizar la capacitación, tus estudiantes deberán demostrar:

- Comprensión de modelos de migración (6R’s).
- Creación de infraestructura Azure usando Azure CLI.
- Configuración completa de un servidor On-Prem.
- Ejecución de migraciones vía rsync.
- Validación del servicio y resolución de fallos comunes.
- Aplicación de buenas prácticas FinOps.
- Uso de documentación técnica profesional.

---

# 🧱 Estructura pedagógica recomendada

El laboratorio está dividido en fases secuenciales. Cada fase debe explicar:

1. **Qué aprenderá el estudiante**  
2. **Por qué es relevante**  
3. **Cómo se realiza (paso a paso)**  
4. **Errores comunes y troubleshooting**  
5. **Cómo aplicar lo aprendido en proyectos reales**

Para clases en vivo:

- Duración recomendada: **2h–3h**
- Nivel requerido: **Intermedio**
- Herramientas requeridas: VSCode, Azure CLI, Linux VM

---

# 📂 Guía de cada fase (visión para instructores)

---

## 1️⃣ Fase 00 – On-Prem Setup

Objetivo del instructor:

- Explicar cómo funciona Apache.
- Mostrar DocumentRoot y estructura HTML.
- Resaltar importancia del origen en migraciones.

Errores comunes:

- Apache no habilitado  
- Firewall local bloqueando puerto 80 (UFW)

---

## 2️⃣ Fase 01 – Discovery & Assessment

Objetivo pedagógico:

- Enseñar Right-Sizing basado en datos reales.
- Explicar importancia de `ss`, `df`, `du`, `ps aux`.

Consejo instructor:

> Comparar resultados de diferentes estudiantes.  
> Algunos tendrán sistemas más cargados y eso cambia el tamaño de la VM.

---

## 3️⃣ Fase 02 – Infraestructura Azure

El instructor debe explicar:

- Modelos de red en Azure.
- Qué es una NSG Rule y por qué es importante.
- Cómo funcionan SSH Keys.
- Importancia de etiquetas (tags) para FinOps.

Errores comunes:

- No copiar `set_env_example.sh` → `set_env.sh`
- No ejecutar `az login`
- Regiones no disponibles

---

## 4️⃣ Fase 03 – Migración (rsync)

Conceptos críticos a reforzar:

- rsync compara bloques, no solo archivos.
- Flags: `-avz` explicado en contexto.
- Importancia de permisos en `/var/www/`.
- Seguridad: por qué no usamos SCP ni FTP.

---

## 5️⃣ Fase 04 – Validación

Qué enfatizar:

- Comparar On-Prem vs Azure.
- Validar Apache tanto externo como interno.
- Logs en `/var/log/apache2/error.log`.

Preguntas sugeridas:

- ¿Cómo sabrías si faltó migrar un archivo?
- ¿Qué pasa si cambia el propietario de los archivos?

---

## 6️⃣ Fase 05 – Cleanup (FinOps)

El instructor debe explicar:

- Costos reales del laboratorio.
- Riesgos de dejar recursos activos.
- Importancia del ciclo de vida completo.

---

# 🧪 Evaluación sugerida para alumnos

- Explicar verbalmente el modelo Lift & Shift.  
- Realizar una migración sin errores.  
- Justificar la SKU seleccionada para la VM en Azure.  
- Identificar fallos en validación.  
- Mostrar cleanup funcional.

---

# 🆘 Troubleshooting común

- SSH rechaza conexión → revisar permisos clave privada.
- `rsync: permission denied` → usar `sudo` en origen.
- `curl` no responde → validar NSG y Apache.

---

# 🧠 Recomendaciones para el instructor

- Comparar arquitectura On-Prem vs Cloud.
- Explicar que rsync es solo una de muchas opciones (AzCopy, Data Box, Movere, App Migration Service).
- Relacionar este laboratorio con procesos de empresas reales.

---

# 📬 Contacto del Autor

Para soporte, colaboraciones académicas o consultoría:

- LinkedIn: https://www.linkedin.com/in/jgaragorry/
- GitHub: https://github.com/jgaragorry/
- TikTok: https://www.tiktok.com/@softtraincorp
- Instagram: https://www.instagram.com/stclatam/
- Comunidad WhatsApp: https://chat.whatsapp.com/ENuRMnZ38fv1pk0mHlSixa

---

# ✔ Fin del Instructor Guide

