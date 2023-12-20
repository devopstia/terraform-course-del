## Example 01 
```s
# Define the Azure provider
provider "azurerm" {
  features {}
}

# Define the Azure resource group
resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US"
}

# Define the Azure virtual network
resource "azurerm_virtual_network" "example" {
  name                = "myVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Define a list of subnet names and address prefixes
variable "subnet_names" {
  default = ["subnet-a", "subnet-b", "subnet-c"]
}

variable "subnet_prefixes" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Create subnets within the virtual network using element function
resource "azurerm_subnet" "example" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [element(var.subnet_prefixes, count.index)]
}
```

```s
variable "region_to_vnet" {
  type    = map(string)
  default = {
    "East US"      = "vnet-east"
    "West US"      = "vnet-west"
    "North Europe" = "vnet-north"
  }
}

# Access the virtual network name for the "East US" region
locals {
  east_us_vnet = element(var.region_to_vnet, "East US")
}
```

```s
variable "vm_sizes" {
  type    = list(string)
  default = ["Standard_A1", "Standard_D2", "Standard_F2", "Standard_DS1"]
}

# Access the third element from the list
locals {
  selected_vm_size = element(var.vm_sizes, 2)
}
```

```s
variable "resource_tags" {
  type = map(string)
  default = {
    "Environment" = "Production"
    "Owner"       = "John Doe"
    "Application" = "WebApp"
  }
}

# Retrieve the value of the "Environment" tag
locals {
  environment_tag = element(var.resource_tags, "Environment")
}

```