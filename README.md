# Azure Cloud-Native DevOps platform
A modular, production-grade DevOps platform for deploying containerized microservices on Azure.
This repository contains reusable Terraform modules, 
Helm charts, GitHub Actions workflows and Ansible playbooks following 
DevOps and cloud engineering best practices.

This platform covers the full DevOps stack:
- **Infrastructure**: Modular Terraform across multiple environments
- **Networking**: Hub-and-spoke VNet topology with private endpoints and DNS
- **Containerization**: Docker multi-stage builds with immutable image tags
- **Orchestration**: Private AKS clusters managed via reusable Helm charts
- **CI/CD**: Reusable GitHub Actions workflows with OIDC authentication
- **Security**: Managed Identities, least-privilege RBAC, Azure Key Vault

## Prerequisites
- Azure CLI
- Terraform
- Ansible
- kubectl + Helm

## Status

- ✅ ACR module
- 🔄 AKS module
- 🔄 Bastion module
- ✅ Key Vault module
- ✅ Key Vault Secret module
- ✅ Managed Identity module
- ✅ Network module
- 🔄 PostgreSQL module
- ✅ Private DNS zone module
- 🔄 Private Endpoint module
- 🔄 Random Password module
- ✅ Role Assignment module
- ✅ Storage Account module
- ✅ Virtual Machine module 
- 🔄 Helm chart + templates
- 🔄 Terraform workflows
- 🔄 CI/CD workflows
- 🔄 Ansible provisioning (playbook + script to call it)
- 🔄 Environment configurations 
- ✅ Bootstrap configuration
- 🔄 Sample app to deploy
- 🔄 Dockerfiles
- 🔄 .gitignore