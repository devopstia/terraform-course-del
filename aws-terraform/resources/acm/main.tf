
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
  aws_region                = "us-east-1"
  domain_name               = "devopssimplelearning.com"
  subject_alternative_names = "*.devopssimplelearning.com"
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


module "acm" {
  source                    = "../../modules/acm"
  aws_region                = local.aws_region
  domain_name               = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  tags                      = local.tags
}
