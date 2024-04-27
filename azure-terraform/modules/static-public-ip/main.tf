resource "azurerm_public_ip" "ingress_controller_ip" {
  name                = format("%s-%s-%s-ingress-controller", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location
  allocation_method   = "Static" # Ensures the IP is static

  tags = var.tags
}
