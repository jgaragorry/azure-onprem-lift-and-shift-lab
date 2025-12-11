#!/usr/bin/env bash
set -euo pipefail

# Crear directorios base
mkdir -p 00-onprem 01-discovery 02-cloud 03-migration 04-validation 05-cleanup docs

# 00-onprem
cd 00-onprem
touch README.md setup_onprem_vm.sh
chmod +x setup_onprem_vm.sh
cd ..

# 01-discovery
cd 01-discovery
touch README.md discovery_onprem.sh
chmod +x discovery_onprem.sh
cd ..

# 02-cloud / azure
cd 02-cloud
mkdir -p azure
cd azure
touch README.md set_env_example.sh create_azure_infra.sh ssh_config_notes.md
chmod +x set_env_example.sh create_azure_infra.sh
cd ../..

# 03-migration / rsync
cd 03-migration
mkdir -p rsync
cd rsync
touch README.md migrate_rsync.sh
chmod +x migrate_rsync.sh
cd ../..

# 04-validation
cd 04-validation
touch README.md validate_migration.sh
chmod +x validate_migration.sh
cd ..

# 05-cleanup
cd 05-cleanup
touch README.md cleanup_azure.sh
chmod +x cleanup_azure.sh
cd ..

# Root READMEs
touch README.md README-students.md README-instructors.md

# docs
cd docs
touch architecture-diagram-mermaid.md concepts-migration-models.md finops-best-practices.md interview-questions-migrations.md
cd ..

