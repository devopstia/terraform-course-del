provider "aws" {
  region = local.aws_region
}

# terraform blocks
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "remote" {
    organization = "S4-ORG"
    workspaces {
      name = "vpc"
    }
  }
}

locals {
  vpc_cidr_block = "10.0.0.0/16"
  aws_region     = "us-east-1"
  cluster_name   = "2526-dev-alpha"
  subnets_cidr_block = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]

  availability_zone = [
    "us-east-1a",
    "us-east-1b",
  ]

  common_tags = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

module "vpc" {
  source                = "./vpc"
  AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  vpc_cidr_block        = local.vpc_cidr_block
  aws_region            = local.aws_region
  subnets_cidr_block    = local.subnets_cidr_block
  availability_zone     = local.availability_zone
  cluster_name          = local.cluster_name
  common_tags           = local.common_tags
}
