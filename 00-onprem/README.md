# Fase 00 – Entorno On-Prem (Simulado)

En esta fase se prepara un servidor Linux local que representará el entorno On-Prem desde el cual realizaremos una migración hacia Azure siguiendo el modelo **Lift & Shift (Rehost)**.

---

## 🎯 Objetivo de esta fase

Configurar un servidor Linux con los siguientes componentes:

- Apache instalado y ejecutándose.
- Servicio habilitado (`systemctl enable apache2`).
- Página HTML dentro de `/var/www/html/` identificando claramente que se trata del servidor "On-Prem".
- Este servidor será la fuente original para la migración en fases posteriores.

---

## 📌 Requisitos previos

- VM Linux local (Ubuntu Server recomendado).
- Permisos sudo.
- Conectividad a Internet.
- Repositorio clonado:

```bash
git clone https://github.com/<tu-usuario>/azure-onprem-lift-and-shift-lab.git
```

---

## 🚀 Pasos para ejecutar esta fase

1. Entrar en el directorio correspondiente:

```bash
cd azure-onprem-lift-and-shift-lab/00-onprem
```

2. Volver ejecutable el script:

```bash
chmod +x setup_onprem_vm.sh
```

3. Ejecutarlo:

```bash
./setup_onprem_vm.sh
```

4. Validar funcionamiento:

```bash
curl http://localhost
```

Deberías ver la página HTML generada.

---

## 📝 ¿Qué hace el script?

- Actualiza la VM.
- Instala Apache.
- Crea un archivo HTML identificando el servidor On-Prem.
- Reinicia y habilita el servicio Apache.
- Realiza una prueba básica con `curl`.

---

## 🔗 Conexión con las siguientes fases

- La fase **01-discovery** analizará este servidor para comprender CPU, RAM, disco, servicios y puertos.
- En **02-cloud/azure** se construirá la infraestructura destino en Azure.
- En **03-migration/rsync** se copiarán archivos desde On-Prem hacia Azure.
- En **04-validation** se verificará que la migración fue exitosa.
- En **05-cleanup** se eliminarán los recursos en Azure para evitar costos.

---

## ✔ Estado final esperado

Puedes acceder localmente a:

```
http://localhost
```

Y deberías ver un mensaje confirmando que estás en el servidor On-Prem.

---

Fin de la Fase 00.

