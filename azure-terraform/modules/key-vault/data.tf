data "azurerm_resource_group" "key_vault" {
  name = format("%s-%s-%s-key-vault", var.tags["id"], var.tags["environment"], var.tags["project"])
}