# Create public subnets
resource "azurerm_subnet" "public_subnet" {
  depends_on           = [azurerm_resource_group.example]
  count                = 3
  name                 = format("%s-%s-%s-public-subnet-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.${count.index + 1}.0/24"]
}

# Create private subnets
resource "azurerm_subnet" "private_subnet" {
  depends_on           = [azurerm_resource_group.example]
  count                = 3
  name                 = format("%s-%s-%s-private-subnet-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.${count.index + 5}.0/24"]
}

