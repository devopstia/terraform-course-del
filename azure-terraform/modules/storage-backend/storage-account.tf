resource "azurerm_storage_account" "mysa" {
  name                     = format("%s%s%sstoragebackend", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name      = data.azurerm_resource_group.storage_backend.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  #   enable_versioning        = true
  blob_properties {
    versioning_enabled = true
  }
  tags = var.tags
}
