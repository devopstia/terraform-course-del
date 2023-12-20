data "azurerm_resource_group" "vnet_resource_group" {
  name = format("%s-%s-%s-learning", var.tags["id"], var.tags["environment"], var.tags["project"])
}

# Virtual networks
data "azurerm_virtual_network" "vnet_name" {
  name                = format("%s-%s-%s-vnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.vnet_resource_group.name
}

# Subnets
data "azurerm_subnet" "vnet_subnet" {
  name                 = format("%s-%s-%s-public-subnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  virtual_network_name = data.azurerm_virtual_network.vnet_name.name
  resource_group_name  = data.azurerm_resource_group.vnet_resource_group.name
}
