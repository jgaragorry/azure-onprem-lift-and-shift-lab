# Fase 02 – Creación de Infraestructura en Azure

En esta fase se creará la infraestructura necesaria en Azure que servirá como destino de la migración desde el servidor On-Prem.

El objetivo es replicar un entorno mínimo pero profesional, usando buenas prácticas reales de diseño en la nube.

---

## 🎯 Objetivo de esta fase

Crear:

- Un Resource Group.
- Una VNet con su Subnet.
- Un Network Security Group (NSG) con las reglas correctas.
- Una IP pública.
- Una NIC asociada al NSG.
- Una VM Linux Ubuntu 24.04.
- SSH habilitado.
- Apache se instalará posteriormente (fase de migración).

Todo se generará mediante **Azure CLI** usando el script `create_azure_infra.sh`.

---

## 📌 Archivos incluidos en esta fase

- `set_env_example.sh` — archivo plantilla para definir variables.
- `create_azure_infra.sh` — script principal que crea la infraestructura.
- `ssh_config_notes.md` — guía para conectarte vía SSH.

---

## 🧪 Preparación antes de ejecutar

1. Debes iniciar sesión en Azure:

```bash
az login
```

2. Copiar el archivo de variables:

```bash
cd 02-cloud/azure
cp set_env_example.sh set_env.sh
```

3. Editar `set_env.sh` con tus valores:

```bash
nano set_env.sh
```

4. Volverlo ejecutable:

```bash
chmod +x set_env.sh
```

---

## 🚀 Creación de la infraestructura

Ejecutar:

```bash
chmod +x create_azure_infra.sh
./create_azure_infra.sh
```

Cuando termine, verás algo como:

```
[02-cloud] VM creada. IP pública: 20.55.129.10
```

---

## 🔗 Conexión con la siguiente fase

Una vez creada la VM en Azure:

- En **03-migration/rsync**, se usarán usuario e IP pública para enviar archivos desde On-Prem.
- En **04-validation**, se probará la aplicación en la VM Azure.
- En **05-cleanup**, se eliminará el Resource Group completo.

---

## ✔ Estado esperado al finalizar esta fase

- Una VM Linux accesible por SSH.
- Red creada correctamente.
- NSG con puertos 22 y 80 abiertos.
- Etiquetas aplicadas para buenas prácticas FinOps.

---

Fin de la Fase 02.

