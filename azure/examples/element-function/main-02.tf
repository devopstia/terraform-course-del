# Define the Azure provider
provider "azurerm" {
  features {}
}

# Define the Azure resource group
resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US"
}

# Define a list of VM names, sizes, and OS images
variable "vm_names" {
  default = ["vm-1", "vm-2", "vm-3"]
}

variable "vm_sizes" {
  default = ["Standard_D2s_v3", "Standard_A2_v2", "Standard_B1ls"]
}

variable "os_images" {
  default = ["UbuntuLTS", "WindowsServer", "CentOS"]
}

# Create virtual machines with different configurations using element function
resource "azurerm_virtual_machine" "example" {
  count                 = length(var.vm_names)
  name                  = var.vm_names[count.index]
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.example[count.index].id]

  vm_size = element(var.vm_sizes, count.index)

  storage_image_reference {
    publisher = "Canonical"
    offer     = element(var.os_images, count.index)
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_names[count.index]
    admin_username = "adminuser"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Create network interfaces for each VM
resource "azurerm_network_interface" "example" {
  count               = length(var.vm_names)
  name                = "nic-${var.vm_names[count.index]}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-${var.vm_names[count.index]}"
    subnet_id                     = azurerm_subnet.example[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a list of subnets
resource "azurerm_subnet" "example" {
  count                = length(var.vm_names)
  name                 = "subnet-${var.vm_names[count.index]}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.${count.index}.0/24"]
}
