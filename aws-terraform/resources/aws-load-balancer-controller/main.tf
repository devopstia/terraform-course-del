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
  aws_region                      = "us-east-1"
  aws-load-balancer-controller-sa = "aws-load-balancer-controller-sa"
  aws-load-balancer-controller-ns = "kube-system"
  eks-controle-plane-name         = "2560-dev-del"
  vpc_id                          = "vpc-06beafd45ef219a5a"
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

module "aws-load-balancer-controller" {
  source                          = "../../modules/aws-load-balancer-controller"
  aws_region                      = local.aws_region
  aws-load-balancer-controller-sa = local.aws-load-balancer-controller-sa
  aws-load-balancer-controller-ns = local.aws-load-balancer-controller-ns
  eks-controle-plane-name         = local.eks-controle-plane-name
  vpc_id                          = local.vpc_id
  tags                            = local.tags
}
