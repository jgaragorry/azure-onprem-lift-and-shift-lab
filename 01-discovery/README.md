# Fase 01 – Discovery & Assessment del Servidor On-Prem

En esta fase realizaremos un análisis técnico completo del servidor On-Prem. Esta es una parte crucial del proceso de migración y además es uno de los puntos más preguntados en entrevistas de roles Cloud, DevOps, Arquitectura y SRE.

El objetivo principal es **entender exactamente cómo funciona el servidor actual**, qué recursos usa y qué dependencias tiene, para poder realizar correctamente un proceso de migración Lift & Shift hacia Azure (o cualquier otra nube).

---

## 🎯 Objetivo de esta fase

Recolectar toda la información necesaria para:

- Dimensionar correctamente la VM destino (Right-Sizing).
- Identificar puertos y servicios necesarios en Azure.
- Evaluar el peso real del contenido a migrar.
- Verificar dependencias de red.
- Reconocer riesgos antes de la migración.

---

## 📌 Información que recolectaremos

El script generará un archivo `.txt` con:

- CPU: cores, arquitectura.
- RAM total y libre.
- Disco: particiones, uso, espacio disponible.
- Tamaño de directorios en `/var/www/`.
- Servicios escuchando puertos (ss -tulpn).
- Procesos que más consumen CPU.
- Procesos que más consumen memoria.
- Estado general del sistema (hostnamectl).

Ejemplo de archivo generado:

```
discovery_onprem_mihost_20250215_143955.txt
```

---

## 🚀 Cómo ejecutar la fase 01

1. Ir al directorio:

```bash
cd azure-onprem-lift-and-shift-lab/01-discovery
```

2. Dar permisos al script:

```bash
chmod +x discovery_onprem.sh
```

3. Ejecutarlo:

```bash
./discovery_onprem.sh
```

4. Revisar el archivo `.txt` generado.

---

## 🧩 Interpretación del Discovery (lo que buscan los reclutadores)

Debes poder responder a preguntas como:

### ¿Cuánta RAM realmente necesita la VM?
Comparando:
- RAM total
- RAM usada (sin cache)
- RAM en uso por Apache

### ¿Qué puertos deben abrirse en Azure?
Dependerá de lo que aparece en:
```
sudo ss -tulpn
```

Ejemplo:
- 22 (SSH)
- 80 (HTTP)

### ¿Qué tamaño de disco usar en Azure?
Dependerá del uso actual de:
```
df -h
du -sh /var/www/*
```

### ¿Qué procesos son críticos?
Evalúa:
```
ps aux --sort=-%cpu
ps aux --sort=-%mem
```

---

## 🔗 Conexión con las siguientes fases

Los datos de esta fase se utilizarán para:

- Crear la VM en Azure con tamaño apropiado (Fase 02).
- Configurar NSG en Azure (puertos 22 y 80).
- Migrar archivos con rsync (Fase 03).
- Validar comportamiento (Fase 04).

---

## ✔ Resultado esperado

Un archivo de inventario completo que te permita justificar técnicamente:

- Tamaño elegido de la VM en Azure.
- Puertos abiertos en el NSG.
- Estrategia de migración seleccionada (Lift & Shift).

---

Fin de la Fase 01.

