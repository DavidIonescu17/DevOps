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
- ✅ Networking module
- 🔄 AKS module
- 🔄 ACR module
- 🔄 Key Vault module
- 🔄 Jumphost + Ansible provisioning
- 🔄 Helm chart
- 🔄 GitHub Actions workflows
