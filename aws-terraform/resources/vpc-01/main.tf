provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }

locals {
  region       = "us-east-1"
  cluster_name = "2560-dev-del"
  # cidr_block   = "10.0.0.0/16"
  cidr_block = "10.10.0.0/16"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "vpc-01" {
  source = "../../modules/vpc-01"
  # source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc-01?ref=main"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}
