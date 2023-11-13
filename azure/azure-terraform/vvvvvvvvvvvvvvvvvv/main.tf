provider "azurerm" {
  features {}
  # subscription_id = "b2feb6c2-ca79-4f27-9e51-0b8605506858"
  # client_id       = "52b0f75c-00b2-404c-acb3-fa28c67b69e1"
  # client_secret   = "Rb48Q~NmvySTnw2qd9ZEXSAy8TYRJkvjkNhN5cwh"
  # tenant_id       = "8165ad28-1985-447c-a63f-ff5bdc6483c4"
  # use_msi         = true
}

resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "East US"
}

output "resource_group_id" {
  value = azurerm_resource_group.example.id
}
