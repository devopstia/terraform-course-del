# Create public IPs
resource "azurerm_public_ip" "example" {
  count               = 3
  name                = format("%s-%s-%s-public-ip-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Dynamic" #Static or Dynamic.
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-public-ip", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

