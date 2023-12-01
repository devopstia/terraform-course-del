provider "aws" {
  region = local.region
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
  region                  = "us-east-1"
  cluster_name            = "2560-dev-del"
  eks_version             = 1.24
  endpoint_private_access = false
  endpoint_public_access  = true

  # public_subnets = {
  #   us-east-1a = "subnet-096d45c28d9fb4c14"
  #   us-east-1b = "subnet-05f285a35173783b0"
  #   us-east-1c = "subnet-0fe3255479ad7c3a4"
  # }

  public_subnets = {
    us-east-1a = "subnet-055cc80108f6ee52a"
    us-east-1b = "subnet-087f82bceda1aab7e"
    us-east-1c = "subnet-02648eade7d335690"
  }

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

module "eks-control-plane" {
  source                  = "../../modules/eks-control-plane"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  tags                    = local.tags
}


# module "eks-control-plane" {
#   source                  = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
#   region                  = local.region
#   cluster_name            = local.cluster_name
#   eks_version             = local.eks_version
#   endpoint_private_access = local.endpoint_private_access
#   endpoint_public_access  = local.endpoint_public_access
#   public_subnets          = local.public_subnets
#   tags                    = local.tags
# }


# module "eks-control-plane" {
#   source                  = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc?ref=main"
#   region                  = local.region
#   cluster_name            = local.cluster_name
#   eks_version             = local.eks_version
#   endpoint_private_access = local.endpoint_private_access
#   endpoint_public_access  = local.endpoint_public_access
#   public_subnets          = local.public_subnets
#   tags                    = local.tags
# }

