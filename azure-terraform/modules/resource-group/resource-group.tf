resource "azurerm_resource_group" "storage_backend" {
  name     = format("%s-%s-%s-storage-backend", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "main" {
  name     = format("%s-%s-%s-rg", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "jenkins_slaves" {
  name     = format("%s-%s-%s-jenkins-slaves", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "key_vault" {
  name     = format("%s-%s-%s-key-vault", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = var.location
  tags     = var.tags
}
