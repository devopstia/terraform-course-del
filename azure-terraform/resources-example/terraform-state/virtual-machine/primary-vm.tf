locals {
  computer_name = upper(var.computer_name)
}

resource "azurerm_public_ip" "public-ip" {
  count               = var.vm-number
  name                = format("%s-%s-%s-vm-public-ip-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
  resource_group_name = azurerm_resource_group.del_resource_group.name
  location            = azurerm_resource_group.del_resource_group.location
  allocation_method   = "Static"
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-vm-public-ip-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
  })
}

resource "azurerm_network_interface" "nic" {
  count                         = var.vm-number
  name                          = format("%s-%s-%s-nic-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
  location                      = azurerm_resource_group.del_resource_group.location
  resource_group_name           = azurerm_resource_group.del_resource_group.name
  enable_accelerated_networking = true

  ip_configuration {
    name                          = format("%s-%s-%s-nic-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
    subnet_id                     = data.azurerm_subnet.vnet_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip[count.index].id
  }
  tags = merge(var.tags, {
    Name = format("%s-%s-%s-nic-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
  })
}

resource "azurerm_network_interface_security_group_association" "attach-nsg" {
  count                     = var.vm-number
  network_interface_id      = azurerm_network_interface.nic[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.vm-number
  name                            = format("%s-%s-%s-${local.computer_name}-%02d", upper(var.tags["id"]), upper(var.tags["environment"]), upper(var.tags["project"]), count.index + 1)
  resource_group_name             = azurerm_resource_group.del_resource_group.name
  location                        = azurerm_resource_group.del_resource_group.location
  computer_name                   = format("${local.computer_name}%02d", count.index + 1)
  size                            = var.size
  admin_username                  = var.rootuser_name
  admin_password                  = var.vm-password
  disable_password_authentication = var.disable_password_authentication
  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id,
  ]
  os_disk {
    caching                   = "ReadWrite"
    disk_size_gb              = var.disk_size_gb
    name                      = format("%s-%s-%s-os-disk-%02d", var.tags["id"], var.tags["environment"], var.tags["project"], count.index + 1)
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
    Name = format("%s-%s-%s-${local.computer_name}-%02d", upper(var.tags["id"]), upper(var.tags["environment"]), upper(var.tags["project"]), count.index + 1)
  })
}
