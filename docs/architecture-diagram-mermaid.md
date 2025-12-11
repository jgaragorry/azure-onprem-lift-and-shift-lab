# Diagrama de Arquitectura – Migración On-Prem → Azure (Lift & Shift)

Este diagrama representa visualmente el flujo del laboratorio:

- Servidor On-Premise (simulado en local)
- Migración de archivos usando SSH + rsync
- Infraestructura creada en Azure (VNet, NSG, VM)
- Conexiones internas y externas

---

## Diagrama (Mermaid)

```mermaid
flowchart LR
    subgraph OnPrem["On-Prem Environment (Simulado)"]
        VM_OnPrem["VM Linux On-Prem<br/>Apache + /var/www/html"]
    end

    subgraph Azure["Azure Subscription"]
        RG["Resource Group"]
        VNet["Virtual Network<br/>10.10.0.0/16"]
        Subnet["Subnet App<br/>10.10.1.0/24"]
        NSG["NSG<br/>Allow: 22, 80"]
        VM_AZ["VM Azure<br/>Ubuntu 24.04<br/>Standard_B1s"]
    end

    Internet["Internet"]

    VM_OnPrem -- "rsync + SSH" --> VM_AZ
    Internet --> VM_AZ
    RG --> VNet --> Subnet --> VM_AZ
    VM_AZ --> NSG
```

---

## Descripción general

- El servidor On-Prem ejecuta Apache con una aplicación simple.
- Se realiza **Discovery** para conocer su configuración.
- Se crea una infraestructura espejo mínima en Azure.
- Se copian los archivos de `/var/www/` mediante `rsync`.
- Finalmente, se valida el comportamiento de la aplicación.

---

Fin del archivo.

