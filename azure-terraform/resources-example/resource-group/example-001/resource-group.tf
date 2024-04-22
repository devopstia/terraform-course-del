# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}


provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myrg" {
  name     = format("%s-%s-%s-learning", var.tags["id"], var.tags["environment"], var.tags["project"])
  location = "eastus"
  tags     = var.tags
}
