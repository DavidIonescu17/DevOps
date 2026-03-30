terraform {
  backend "azurerm" {
    tenant_id            = "5a4863ed-40c8-4fd5-8298-fbfdb7f13095"
    subscription_id      = "45aa2ad0-8e4e-4194-9162-7a98c645ae3c"
    resource_group_name  = "devops-shared-rg"
    storage_account_name = "devopsstatestorage"
    container_name       = "terraform"
    key                  = "shared/tfstate"
  }
}