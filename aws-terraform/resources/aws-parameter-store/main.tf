provider "aws" {
  region = local.aws_region
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
  aws_region = "us-east-1"
  aws-param-values = [
    "mysql-db",
    "postges-aurora",
    "postgres-db",
    "mysql-aurora-db"
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

module "aws-parameter-store" {
  source           = "../../modules/aws-parameter-store"
  aws_region       = local.aws_region
  aws-param-values = local.aws-param-values
  tags             = local.tags
}
