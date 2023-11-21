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
  aws_region         = "us-east-1"
  namespace          = "namespace"
  control_plane_name = "2560-dev-del"
}

module "argo-cd-helm" {
  source             = "../../modules/argo-cd-helm"
  aws_region         = local.aws_region
  namespace          = local.namespace
  control_plane_name = local.control_plane_name
}
