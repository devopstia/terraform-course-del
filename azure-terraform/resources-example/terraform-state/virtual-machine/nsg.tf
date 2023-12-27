resource "azurerm_network_security_group" "nsg" {
  name = format("%s-%s-%s-vm-nsg", var.tags["id"], var.tags["environment"], var.tags["project"])

  resource_group_name = azurerm_resource_group.del_resource_group.name
  location            = azurerm_resource_group.del_resource_group.location

  # SSH
  security_rule {
    name                       = "default-allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # ALL PORTS
  security_rule {
    name                       = "all-ports"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # ICMP
  security_rule {
    name                       = "ICMP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow-all-outbound"
    priority                   = 400
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
