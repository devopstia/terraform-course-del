resource "azurerm_resource_group" "example" {
  name     = format("%s-%s-%s-dns-zone", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "East US"
}

# resource "azurerm_dns_zone" "example" {
#   # This name should be the domain name that you would like to brink in Azure
#   name = "devopssimplelearning.com"
#   #   resource_group_name = data.azurerm_resource_group.rg.name
#   resource_group_name = azurerm_resource_group.example.name

#   tags = var.tags
# }


resource "azurerm_dns_zone" "example" {
  # This name should be the domain name that you would like to brink in Azure
  name = "devopseasylearning.net"
  #   resource_group_name = data.azurerm_resource_group.rg.name
  resource_group_name = azurerm_resource_group.example.name

  tags = var.tags
}
