# Fase 05 – Cleanup de Azure (FinOps)

Esta fase destruye todos los recursos creados en Azure para evitar costos innecesarios.  
En un entorno profesional, el cleanup es esencial para mantener gastos controlados y evitar cargos por recursos olvidados.

Este laboratorio sigue buenas prácticas FinOps:  
**siempre eliminar recursos cuando no se utilicen más**.

---

## 🎯 Objetivo de esta fase

- Eliminar el Resource Group creado en la Fase 02.
- Asegurar que no queden recursos huérfanos.
- Evitar gastos innecesarios en la suscripción Azure.
- Validar que todo el entorno del laboratorio se destruyó correctamente.

---

## 📦 Archivos de esta fase

- `cleanup_azure.sh` — script principal que elimina el Resource Group.
- `README.md` — instrucciones de uso.

---

## 🔧 Requisitos antes de continuar

1. Haber ejecutado todas las fases anteriores del laboratorio.  
2. Tener el archivo `set_env.sh` generado en `02-cloud/azure/`.  
3. Haber iniciado sesión en Azure CLI:

```bash
az login
```

---

## 🚀 Ejecutar Cleanup

Desde la carpeta del laboratorio:

```bash
cd azure-onprem-lift-and-shift-lab/05-cleanup
chmod +x cleanup_azure.sh
./cleanup_azure.sh
```

El script pedirá confirmación:

```
¿Estás seguro que deseas eliminar todo el Resource Group rg-mig-lab? (yes/no):
```

Debes responder:

```
yes
```

---

## 📌 ¿Qué elimina exactamente este script?

El Resource Group completo, incluyendo:

- VM Linux
- Red Virtual (VNet)
- Subnet
- NSG
- NIC
- IP Pública
- Discos administrados
- Cualquier otro recurso creado durante la migración

---

## ✔ Resultado esperado

Un mensaje indicando:

```
[05-cleanup] Eliminación iniciada para el Resource Group rg-mig-lab.
```

Luego:

```
El Resource Group ya no existe.
```

---

## 🧩 ¿Por qué es importante esta fase en entrevistas?

Los equipos de Cloud y FinOps buscan personas que:

- Creen recursos automatizadamente.
- Los eliminen de forma controlada.
- No generen costos innecesarios.
- Documenten el ciclo completo (creación → uso → cleanup).

Este laboratorio muestra dominio del ciclo completo de un entorno en la nube.

---

Fin de la Fase 05.

