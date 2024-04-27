# terraform {
#   backend "azurerm" {
#     resource_group_name  = "2560-dev-del-storage-backend"
#     storage_account_name = "2560devdelstoragebackend"
#     container_name       = "2560devdelstoragecontainer"
#     key                  = "aks-controle-plane/terraform.tfstate"
#   }
# }