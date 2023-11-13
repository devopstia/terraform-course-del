
# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}


provider "azurerm" {
  features {}
}

# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "myrg1" {
  name     = "learning2"
  location = "East US"
}

# Resource-2: Random String 
resource "random_string" "myrandom" {
  length  = 16
  upper   = false
  special = false
}

# Resource-3: Azure Storage Account 
resource "azurerm_storage_account" "mysa" {
  name                     = "mysa${random_string.myrandom.id}"
  resource_group_name      = azurerm_resource_group.myrg1.name
  location                 = azurerm_resource_group.myrg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.common_tags
}

resource "azurerm_storage_container" "example" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.mysa.name
  container_access_type = "container" # Specify the access type for the container (private, blob, container)
}
