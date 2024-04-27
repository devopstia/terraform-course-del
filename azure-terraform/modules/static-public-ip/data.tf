data "azurerm_resource_group" "rg" {
  name = format("%s-%s-%s-rg", var.tags["id"], var.tags["environment"], var.tags["project"])
}

# data "azurerm_public_ip" "example" {
#   name                = azurerm_public_ip.example.name
#   resource_group_name = azurerm_resource_group.example.name
# }

data "azurerm_public_ip" "example" {
  depends_on = [
    azurerm_public_ip.ingress_controller_ip
  ]
  name                = format("%s-%s-%s-ingress-controller", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.example.ip_address
}