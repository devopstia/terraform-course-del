data "azurerm_resource_group" "storage_backend" {
  name = format("%s-%s-%s-storage-backend", var.tags["id"], var.tags["environment"], var.tags["project"])
}