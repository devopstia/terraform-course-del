# Create NAT Gateway
resource "azurerm_nat_gateway" "example" {
  count               = 3
  name                = format("%s-%s-%s-nat-gateway-${count.index + 1}", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-nat-gateway", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "azurerm_subnet_nat_gateway_association" "example" {
  count          = 3
  subnet_id      = azurerm_subnet.private_subnet[count.index].id
  nat_gateway_id = azurerm_nat_gateway.example[count.index].id
}
