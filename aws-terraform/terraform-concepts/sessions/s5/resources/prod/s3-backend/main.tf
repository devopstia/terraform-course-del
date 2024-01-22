terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

locals {
  aws_region = "us-west-1"
  common_tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "production"
    "project"        = "s5"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "s3-backend" {
  source      = "../../../modules/s3-backend"
  aws_region  = local.aws_region
  common_tags = local.common_tags
}