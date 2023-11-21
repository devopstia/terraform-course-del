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
  aws_region              = "us-east-1"
  eks_version             = 1.24
  endpoint_private_access = false
  endpoint_public_access  = true

  public_subnets = {
    us-east-1a = "subnet-0f5449f8eb943a4ad"
    us-east-1b = "subnet-02bf0c3a3fd83071f"
    us-east-1c = "subnet-0ae692e4e1d26f3b4"
  }

  private_subnets = {
    us-east-1a = "subnet-02622d73204514286"
    us-east-1b = "subnet-0d4e63819baf2844c"
    us-east-1c = "subnet-0346f91f492ccfaa8"
  }

  common_tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "eks-fargate-only" {
  source                  = "../../modules/eks-fargate-only"
  aws_region              = local.aws_region
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  private_subnets         = local.private_subnets
  common_tags             = local.common_tags
}
