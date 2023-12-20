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
