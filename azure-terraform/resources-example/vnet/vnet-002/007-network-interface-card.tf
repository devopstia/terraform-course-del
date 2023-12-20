# Create Network Interface Cards (NICs)
resource "azurerm_network_interface" "public_nic" {
  count               = 3
  name                = format("%s-%s-%s-public-nic", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.public_subnet[count.index].id
    public_ip_address_id          = azurerm_public_ip.example[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-public-nic", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "azurerm_network_interface" "private_nic" {
  count               = 3
  name                = format("%s-%s-%s-private-nsg", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.private_subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-private-nsg", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}
