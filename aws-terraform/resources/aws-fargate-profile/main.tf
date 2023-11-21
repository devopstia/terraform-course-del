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
  aws_region   = "us-east-1"
  cluster_name = "2560-dev-del"
  private_subnets = {
    us-east-1a = "subnet-0346f91f492ccfaa8"
    us-east-1b = "subnet-0d4e63819baf2844c"
    us-east-1c = "subnet-02622d73204514286"
  }

  fargate-profiles = [
    # "external-dns",
    "app",
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

module "aws-fargate-profile" {
  source           = "../../modules/aws-fargate-profile"
  aws_region       = local.aws_region
  cluster_name     = local.cluster_name
  private_subnets  = local.private_subnets
  fargate-profiles = local.fargate-profiles
  tags             = local.tags
}
