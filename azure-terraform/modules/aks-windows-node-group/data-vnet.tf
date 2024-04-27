# Retrieve existing Virtual Network
data "azurerm_virtual_network" "existing_vnet" {
  name                = format("%s-%s-%s-aks-net", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Retrieve existing Subnet
data "azurerm_subnet" "existing_subnet" {
  name                 = format("%s-%s-%s-aks-subnet", var.tags["id"], var.tags["environment"], var.tags["project"])
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

# Now you can use the IDs retrieved from data sources as needed
output "vnet_id" {
  value = data.azurerm_virtual_network.existing_vnet.id
}

output "subnet_id" {
  value = data.azurerm_subnet.existing_subnet.id
}