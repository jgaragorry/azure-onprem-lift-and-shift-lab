# Notas de Conexión SSH – VM Azure

Una vez creada la VM Linux en Azure, podrás conectarte por SSH usando:

```bash
ssh azureuser@<IP_PUBLICA>
```

La clave pública fue generada automáticamente por el comando:

```
az vm create --generate-ssh-keys
```

---

## 🚨 Si no puedes conectarte por SSH

Verificar:

1. La IP pública correcta:

```bash
az vm show -d -g rg-mig-lab -n vm-mig-azure --query publicIps -o tsv
```

2. Regla del NSG para puerto 22 está habilitada:

```bash
az network nsg rule list -g rg-mig-lab --nsg-name nsg-mig-lab -o table
```

Debe aparecer:

```
Allow-SSH   22   Allow   Inbound
```

3. Permisos correctos en `~/.ssh`:

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
```

---

## 📌 Sugerencia opcional para facilitar SSH

Puedes agregar entrada a tu archivo:

```
~/.ssh/config
```

Ejemplo:

```
Host azuremig
    HostName <IP_PUBLICA>
    User azureuser
    IdentityFile ~/.ssh/id_rsa
```

Luego solo ejecutas:

```bash
ssh azuremig
```

---

Fin del archivo.

