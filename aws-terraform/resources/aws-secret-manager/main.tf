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
  aws-secret-string = [
    # "mysql-db-password",
    # "postges-aurora-db-password",
    # "postgres-db",
    # "mysql-aurora-db-password"
    "artifactory-db-username",
    "artifactory-db-password"
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

module "aws-secret-manager" {
  source            = "../../modules/aws-secret-manager"
  aws_region        = local.aws_region
  aws-secret-string = local.aws-secret-string
  tags              = local.tags
}
