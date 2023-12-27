# Create Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = format("%s-%s-%s-vnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-vnet", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}