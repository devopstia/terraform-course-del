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
  aws-ebs-csi-driver-sa   = "aws-ebs-csi-driver-sa"
  aws-ebs-csi-driver-ns   = "aws-ebs-csi-driver"
  eks-controle-plane-name = "2560-dev-del"
  storage-class-name      = "2560-dev-del"
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

module "aws-ebs-csi-driver" {
  source                  = "../../modules/aws-ebs-csi-driver"
  aws_region              = local.aws_region
  aws-ebs-csi-driver-sa   = local.aws-ebs-csi-driver-sa
  aws-ebs-csi-driver-ns   = local.aws-ebs-csi-driver-ns
  eks-controle-plane-name = local.eks-controle-plane-name
  storage-class-name      = local.storage-class-name
  tags                    = local.tags
}
