## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 3.76.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.69.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = var.aws_region
}

