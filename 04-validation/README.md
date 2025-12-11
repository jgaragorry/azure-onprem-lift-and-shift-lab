# Fase 04 – Validación de la Migración

En esta fase verificaremos que la migración On-Prem → Azure fue exitosa.  
El objetivo es asegurar que:

- La aplicación responde correctamente en la VM Azure.
- El contenido migrado coincide con el origen.
- Apache está funcionando tanto en localhost (Azure) como desde Internet.
- Los puertos están abiertos y accesibles.
- No existen diferencias inesperadas entre los entornos.

Esta validación es crítica en cualquier proceso de migración real y es altamente valorada en entrevistas de roles Cloud y DevOps.

---

## 🎯 Objetivos de la Validación

- Realizar pruebas funcionales:
  - `curl http://<IP_PUBLICA_AZURE>`
- Realizar validación interna:
  - `curl http://localhost` dentro de la VM Azure.
- Comparar estructura de archivos:
  - `/var/www/html` en On-Prem vs Azure.
- Validar que el servicio Apache está activo.

---

## 📦 Archivos de esta fase

- `validate_migration.sh` — script automatizado para realizar validaciones.
- `README.md` — instrucciones detalladas.

---

## 🚀 Cómo ejecutar la validación

Ejecutar en tu servidor On-Prem:

```bash
cd azure-onprem-lift-and-shift-lab/04-validation
chmod +x validate_migration.sh
./validate_migration.sh <usuario_azure> <ip_publica>
```

Ejemplo:

```bash
./validate_migration.sh azureuser 20.88.42.100
```

---

## 📌 ¿Qué revisa este script?

1. **Validación desde tu máquina local:**

```bash
curl http://<IP_PUBLICA>
```

2. **Validación dentro de Azure:**

```bash
ssh azureuser@<IP> "curl http://localhost"
```

3. **Comparación de archivos:**

- Lista de archivos en On-Prem
- Lista de archivos en Azure

4. **Verificación de Apache:**

- Apache corriendo
- Respuesta HTTP válida
- Estructura replicada

---

## ✔ Resultado esperado

Un mensaje indicando:

```
Validación completada. La migración es consistente.
```

Y la página mostrada desde Azure debe coincidir con la de On-Prem.

---

## 🧩 Conexión con la siguiente fase

Una vez validada la migración:

- En **Fase 05 – Cleanup** se limpiará el entorno en Azure para evitar costos.
- Esto cierra el ciclo completo del laboratorio de migración.

---

Fin de la Fase 04.

