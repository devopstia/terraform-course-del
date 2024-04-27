resource "azurerm_storage_container" "example" {
  name                  = format("%s%s%sstoragecontainer", var.tags["id"], var.tags["environment"], var.tags["project"])
  storage_account_name  = azurerm_storage_account.mysa.name
  container_access_type = "private"
}