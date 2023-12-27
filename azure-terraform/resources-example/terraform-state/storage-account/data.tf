data "azurerm_resource_group" "resource_group" {
  name = format("%s-%s-%s-learning-vnet", var.tags["id"], var.tags["environment"], var.tags["project"])
}
