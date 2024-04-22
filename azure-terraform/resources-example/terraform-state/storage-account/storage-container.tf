provider "azurerm" {
  features {}
}

resource "random_string" "myrandom" {
  length  = 5
  upper   = false
  special = false
}

resource "azurerm_resource_group" "myrg" {
  name     = format("%s-%s-%s-storage", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "eastus"
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-storage", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "azurerm_storage_account" "mysa" {
  name                     = "terraformstorage${random_string.myrandom.id}"
  resource_group_name      = azurerm_resource_group.myrg.name
  location                 = azurerm_resource_group.myrg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  # enable_versioning        = true
  blob_properties {
    versioning_enabled = true
  }
  tags = var.tags
}

resource "azurerm_storage_container" "example" {
  name                  = "terraformsblock${random_string.myrandom.id}"
  storage_account_name  = azurerm_storage_account.mysa.name
  container_access_type = "private"
}