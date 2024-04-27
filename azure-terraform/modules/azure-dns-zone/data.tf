data "azurerm_resource_group" "rg" {
  name = format("%s-%s-%s-rg", var.tags["id"], var.tags["environment"], var.tags["project"])
}