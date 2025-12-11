# Fase 03 – Migración con rsync (Lift & Shift)

En esta fase realizaremos la migración real del contenido del servidor On-Prem hacia la VM de Azure utilizando **rsync** sobre **SSH**.  
Este método es simple, seguro y ampliamente usado en migraciones básicas de servidores Linux.

---

## 🎯 Objetivo de esta fase

- Copiar la carpeta `/var/www/` desde el servidor On-Prem hacia la VM Linux en Azure.
- Mantener permisos, estructura y archivos.
- Verificar que la aplicación queda funcionando en Azure después de la migración.
- Realizar la operación utilizando el modelo **Lift & Shift (Rehost)**.

---

## 📦 Archivos de esta fase

- `migrate_rsync.sh` — script de migración.
- `README.md` — instrucciones para ejecutarlo.

---

## 🔧 Requisitos antes de ejecutar

1. Haber ejecutado correctamente:
   - **Fase 00** (servidor On-Prem).
   - **Fase 01** (Discovery).
   - **Fase 02** (Infra en Azure).

2. Tener la IP pública de la VM creada en Azure:

```bash
az vm show -d -g rg-mig-lab -n vm-mig-azure --query publicIps -o tsv
```

3. Poder conectarte por SSH:

```bash
ssh azureuser@<IP_PUBLICA>
```

---

## 🚀 Ejecución del script de migración

En el servidor On-Prem (tu VM local), ejecutar:

```bash
cd azure-onprem-lift-and-shift-lab/03-migration/rsync
chmod +x migrate_rsync.sh
./migrate_rsync.sh <usuario_azure> <ip_publica>
```

Ejemplo real:

```bash
./migrate_rsync.sh azureuser 20.88.42.100
```

---

## 📌 ¿Qué hace exactamente este script?

1. Prueba conexión SSH hacia Azure.  
2. Instala Apache en la VM Azure (si no está instalado).  
3. Ejecuta:

```bash
rsync -avz /var/www/ azureuser@IP:/var/www/
```

4. Reinicia Apache en Azure.  
5. Valida respuesta básica del servicio.

---

## ✔ Validación posterior a la migración

Probar desde tu máquina local:

```bash
curl http://<IP_PUBLICA_AZURE>
```

Si ves la misma página que en On-Prem, la migración fue exitosa.

---

## 🧩 Conexión con la siguiente fase

En la **Fase 04** validaremos más profundamente:

- Estructura de archivos.
- Accesibilidad desde ambos lados.
- Servicios y puertos.
- Comportamiento de Apache.

---

## 📝 Resultado esperado

- Archivos de la aplicación replicados en la VM Azure.
- Apache ejecutándose con la misma página que en On-Prem.
- Migración funcional completa estilo “Lift and Shift”.

---

Fin de la Fase 03.

