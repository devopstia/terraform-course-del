# Create Network Security Groups
resource "azurerm_network_security_group" "public_nsg" {
  count               = 3
  name                = format("%s-%s-%s-public-nsg", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

resource "azurerm_network_security_group" "private_nsg" {
  count               = 3
  name                = format("%s-%s-%s-private-nsg", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}

