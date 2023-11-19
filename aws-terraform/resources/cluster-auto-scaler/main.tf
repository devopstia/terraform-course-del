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
  cluster-autoscaler-sa   = "cluster-autoscaler-sa"
  cluster-autoscaler-ns   = "cluster-autoscaler"
  eks-controle-plane-name = "2560-dev-del"
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

module "cluster-auto-scaler" {
  source                  = "../../modules/cluster-auto-scaler"
  aws_region              = local.aws_region
  cluster-autoscaler-sa   = local.cluster-autoscaler-sa
  cluster-autoscaler-ns   = local.cluster-autoscaler-ns
  eks-controle-plane-name = local.eks-controle-plane-name
  tags                    = local.tags
}
