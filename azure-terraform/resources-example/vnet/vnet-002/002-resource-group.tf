resource "azurerm_resource_group" "example" {
  name     = format("%s-%s-%s-learning", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "eastus"
  tags     = var.tags
}