terraform {
  backend "azurerm" {
    resource_group_name  = "2560-dev-del-storage"
    storage_account_name = "terraformstoragehwn9o"
    container_name       = "terraformsblockhwn9o"
    key                  = "virtual-machine/terraform.tfstate"
  }
}