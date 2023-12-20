locals {
  computer_name = upper(var.computer_name)
}

resource "azurerm_public_ip" "public-ip" {
  name                = format("%s-%s-%s-vm-public-ip", var.tags["id"], var.tags["environment"], var.tags["project"])
  resource_group_name = azurerm_resource_group.del_resource_group.name
  location            = azurerm_resource_group.del_resource_group.location
  allocation_method   = "Static"
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-vm-public-ip", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "azurerm_network_interface" "nic" {
  name                          = format("%s-%s-%s-nic", var.tags["id"], var.tags["environment"], var.tags["project"])
  location                      = azurerm_resource_group.del_resource_group.location
  resource_group_name           = azurerm_resource_group.del_resource_group.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = format("%s-%s-%s-nic", var.tags["id"], var.tags["environment"], var.tags["project"])
    subnet_id                     = data.azurerm_subnet.vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-nic", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

resource "azurerm_network_interface_security_group_association" "attach-nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = format("%s-%s-%s-${local.computer_name}", upper(var.tags["id"]), upper(var.tags["environment"]), upper(var.tags["project"]))
  resource_group_name             = azurerm_resource_group.del_resource_group.name
  location                        = azurerm_resource_group.del_resource_group.location
  computer_name                   = upper(var.computer_name)
  size                            = var.size
  admin_username                  = var.rootuser_name
  admin_password                  = var.vm-password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  os_disk {
    caching                   = "ReadWrite"
    disk_size_gb              = var.disk_size_gb
    name                      = format("%s-%s-%s-os-disk", var.tags["id"], var.tags["environment"], var.tags["project"])
    storage_account_type      = var.storage_account_type
    write_accelerator_enabled = "false"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/learning-terraform-azure.pub")
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-${local.computer_name}", upper(var.tags["id"]), upper(var.tags["environment"]), upper(var.tags["project"]))
    },
  )
}
