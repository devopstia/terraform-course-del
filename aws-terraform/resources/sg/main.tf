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
  sg_name    = "bastion-sg"

  allowed_ports = [
    22,
    80,
    8080,
    443
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

module "sg" {
  source        = "../../modules/sg"
  aws_region    = local.aws_region
  vpc_id        = local.vpc_id
  sg_name       = local.sg_name
  allowed_ports = local.allowed_ports
  tags          = local.tags
}
