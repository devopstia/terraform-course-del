# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = format("%s-%s-%s-public-subnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.myrg.name
  address_prefixes     = ["10.0.2.0/24"]
}
