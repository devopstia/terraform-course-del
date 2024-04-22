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
  aks_control_plane_name = "2560-dev-del"
  aks_rg                 = "2560-dev-del-rg"

  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

}

module "aks-auth-config" {
  source                 = "../../modules/aks-auth-config"
  aks_control_plane_name = local.aks_control_plane_name
  aks_rg                 = local.aks_rg
  tags                   = local.tags
}
