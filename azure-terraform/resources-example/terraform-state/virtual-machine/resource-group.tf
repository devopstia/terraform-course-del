resource "azurerm_resource_group" "del_resource_group" {
  name     = format("%s-%s-%s-learning-vm", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = var.location
}
