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
  aws_region          = "us-east-1"
  aws-readonly-group  = "AWS-READONLY-GROUP"
  aws-eks-admin-group = "AWS-EKS-ADMIN-GROUP"
  aws-admin-group     = "AWS-ADMIN-GROUP"

  aws-eks-admin-users = [
    "awseksadmin1",
    "awseksadmin2",
    "awseksadmin3"
  ]

  aws-readonly-users = [
    "awsreadonly1",
    "awsreadonly2",
    "awsreadonly3"
  ]

  aws-admin-users = [
    "awsadmin1",
    "awsadmin2",
    "awsadmin3"
  ]

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

module "iam-without-role" {
  source              = "../../modules/iam-without-role"
  aws_region          = local.aws_region
  aws-readonly-group  = local.aws-readonly-group
  aws-eks-admin-group = local.aws-eks-admin-group
  aws-admin-group     = local.aws-admin-group
  aws-eks-admin-users = local.aws-eks-admin-users
  aws-readonly-users  = local.aws-readonly-users
  aws-admin-users     = local.aws-admin-users
  common_tags         = local.common_tags
}
