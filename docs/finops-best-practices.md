# Buenas Prácticas FinOps para Migraciones y Laboratorios Cloud

Este documento aplica recomendaciones de FinOps para evitar costos innecesarios en Azure durante laboratorios y migraciones reales.

---

## 1. Elegir tamaños de VM pequeños

Para laboratorios:
- `Standard_B1s`
- `Standard_B2s`

Son ideales por:
- Bajo costo
- Suficiente performance para pruebas
- Facturación por hora

---

## 2. Seleccionar regiones económicas

Ejemplos típicos:
- `eastus`
- `westeurope`

Evitar regiones premium salvo que se requiera.

---

## 3. Aplicar etiquetas (tags)

Ejemplo recomendado:

```
env=lab
project=onprem-migration
owner=jgaragorry
costcenter=training
```

Permite:
- Filtrar recursos
- Analizar costos por proyecto
- Trazabilidad en auditorías

---

## 4. Definir tiempo de vida del recurso

Antes de crear la VM, responder:

- ¿Cuánto tiempo estará activa?
- ¿Cuándo debe eliminarse?
- ¿Quién será responsable del cleanup?

Esto evita gastos por recursos olvidados.

---

## 5. Automatizar cleanup

Siempre incluir un script como:

```
az group delete --name <RG> --yes --no-wait
```

Garantiza que:
- No quedan recursos huérfanos
- Los discos administrados también se eliminan
- El costo final es mínimo

---

## 6. Monitorear el costo total del laboratorio

Usar Azure Cost Management para revisar:

- Costo por recurso
- Costo por etiqueta
- Consumo histórico

---

Fin del archivo.

