# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = format("%s-%s-%s-aks-net", var.tags["id"], var.tags["environment"], var.tags["project"])
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/8"]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = format("%s-%s-%s-aks-subnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
  address_prefixes     = ["10.240.0.0/16"]
}

