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
  vpc_id     = "vpc-068852590ea4b093b"
  sg_name    = "vm-sg"

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

module "sg-open-all-ports" {
  source     = "../../modules/sg-open-all-ports"
  aws_region = local.aws_region
  vpc_id     = local.vpc_id
  sg_name    = local.sg_name
  tags       = local.tags
}
