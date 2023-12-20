resource "azurerm_resource_group" "myrg" {
  name     = format("%s-%s-%s-learning-vnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "East US"
  tags     = var.tags
}