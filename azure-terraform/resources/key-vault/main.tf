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

locals {
  location        = "eastus"
  subscription_id = "c344bf80-ed9d-4630-b1a7-4c9d3225a111"
  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "azure"
  }
}

module "key-vault" {
  source          = "../../modules/key-vault"
  location        = local.location
  subscription_id = local.subscription_id
  tags            = local.tags
}
