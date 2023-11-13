## Example
```s
variable "virtual_machines" {
  type = map(object({
    vm_size         = string
    admin_username  = string
    admin_password  = string
    tags            = map(string)
  }))
  default = {
    "vm1" = {
      vm_size         = "Standard_DS2_v2"
      admin_username  = "adminuser"
      admin_password  = "P@ssw0rd123"
      tags = {
        environment = "dev"
        role        = "web"
      }
    }
    "vm2" = {
      vm_size         = "Standard_D2s_v3"
      admin_username  = "adminuser"
      admin_password  = "P@ssw0rd456"
      tags = {
        environment = "prod"
        role        = "app"
      }
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "my-resource-group"
  location = "East US"
}

resource "azurerm_linux_virtual_machine" "vm1" {
  # name                  = "vm1"
  name                  = format("%s-%s-vm", var.virtual_machines["vm1"].tags["environment"], var.virtual_machines["vm1"].tags["role"])
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = var.virtual_machines["vm1"].vm_size
  admin_username        = var.virtual_machines["vm1"].admin_username
  admin_password        = var.virtual_machines["vm1"].admin_password
  network_interface_ids = []  # Add your network interface configuration here

  tags = var.virtual_machines["vm1"].tags
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                  = "vm2"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = var.virtual_machines["vm2"].vm_size
  admin_username        = var.virtual_machines["vm2"].admin_username
  admin_password        = var.virtual_machines["vm2"].admin_password
  network_interface_ids = []  # Add your network interface configuration here

  tags = var.virtual_machines["vm2"].tags
}
```

## terraform.tfvars
```s
virtual_machines = {
  "vm1" = {
    vm_size        = "Standard_DS2_v2"
    admin_username = "adminuser"
    admin_password = "P@ssw0rd123"
    tags = {
      environment = "dev"
      role        = "web"
    }
  }
  "vm2" = {
    vm_size        = "Standard_D2s_v3"
    admin_username = "adminuser"
    admin_password = "P@ssw0rd456"
    tags = {
      environment = "prod"
      role        = "app"
    }
  }
}
```