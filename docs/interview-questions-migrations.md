# Preguntas de Entrevista sobre Migraciones On-Prem → Cloud

Este documento reúne preguntas típicas para roles:

- DevOps Engineer  
- Cloud Engineer (Azure / AWS)  
- SRE  
- Cloud Architect  
- Migration Specialist  

Incluye las respuestas y puntos clave.

---

## 1. ¿Cuál es la diferencia entre Lift & Shift, Replatform y Refactor?

Puntos clave:

- **Lift & Shift:** mover tal cual sin modificar la app.
- **Replatform:** mover con pequeñas mejoras (DB administrada, App Service).
- **Refactor:** rediseñar la app a arquitectura cloud-native.

---

## 2. ¿Cómo realizas el discovery de un servidor On-Prem antes de migrarlo?

Mencionar:

- CPU (`lscpu`)
- RAM (`free -h`)
- Disco (`df -h`, `du -sh`)
- Servicios (`ss -tulpn`)
- Procesos (`ps aux`)
- Identificación de dependencias externas
- Versiones de software
- Tamaño de la aplicación (`/var/www/`)

---

## 3. ¿Cómo determinas el tamaño correcto de una VM en Azure (Right-Sizing)?

Debes responder:

- Basado en uso real, no en configuración del servidor.
- Analizo CPU, memoria, disco, IOPS.
- Selecciono la SKU más cercana y económica.
- Empiezo con B-Series para ambientes no productivos.
- Ajusto luego si es necesario (observabilidad + métricas).

---

## 4. ¿Qué riesgos tiene un Lift & Shift directo?

Riesgos típicos:

- Sobrecostos por sobredimensionamiento.
- No se optimiza tiempo de respuesta.
- Dependencias no detectadas.
- Seguridad no mejorada automáticamente.
- Configuraciones heredadas obsoletas.

---

## 5. ¿Qué configuraciones de red se deben considerar al migrar a Azure?

Responder:

- VNet
- Subnet
- NSG (reglas inbound/outbound)
- IP pública
- Route tables (si aplica)
- Seguridad por SSH keys

---

## 6. ¿Cómo validarías una migración?

Checklist:

- `curl http://<IP>`
- Validar desde dentro de la VM (localhost)
- Comparación de archivos On-Prem vs Azure
- Verificación de Apache
- Estado del servicio (systemctl)
- Logs sin errores

---

## 7. ¿Qué papel juega FinOps en una migración?

Responder:

- Dimensionamiento correcto (Right-Sizing)
- Automatizar cleanup
- Uso de etiquetas
- Elegir regiones más económicas
- Minimizar recursos innecesarios

---

## 8. ¿Qué harías después de una migración exitosa?

Responde:

- Pruebas de rendimiento
- Monitoreo continuo
- Validación con stakeholders
- Documentación final
- Plan de decommission del servidor On-Prem

---

Fin del archivo.

