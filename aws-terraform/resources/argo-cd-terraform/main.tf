provider "aws" {
  region = local.aws_region
}

terraform {
  required_version = ">= 1.0"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
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
  env        = "staging"
}

module "argo-cd-terraform" {
  source     = "../../modules/argo-cd-terraform"
  aws_region = local.aws_region
  env        = local.env
}
