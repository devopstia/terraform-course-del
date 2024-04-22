# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "2560-dev-del-storage"
    storage_account_name = "terraformstorage0akrc"
    container_name       = "terraformsblock0akrc"
    key                  = "resource-group-test/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = format("%s-%s-%s-learning-test", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "eastus"
  tags     = var.tags
}
