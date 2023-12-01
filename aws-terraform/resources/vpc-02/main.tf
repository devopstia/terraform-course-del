
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Provider Block
provider "aws" {
  region = local.aws_region
}

# terraform {
#   backend "s3" {
#     bucket         = ""
#     key            = ""
#     region         = ""
#     dynamodb_table = ""
#   }
# }

locals {
  private-subnets-cdir = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
  ]
  public-subnet-cidr = [
    "10.10.4.0/24",
    "10.10.5.0/24",
    "10.10.6.0/24",
  ]
  aws_availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
  aws_region                       = "us-east-1"
  cidr_block                       = "10.10.0.0/16"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  cluster_name                     = "2560-dev-del"
}

module "vpc-02" {
  source = "../../modules/vpc-02/"
  # source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc-02?ref=main"
  aws_region                       = local.aws_region
  cidr_block                       = local.cidr_block
  public-subnet-cidr               = local.public-subnet-cidr
  private-subnets-cdir             = local.private-subnets-cdir
  aws_availability_zones           = local.aws_availability_zones
  instance_tenancy                 = local.instance_tenancy
  enable_dns_support               = local.enable_dns_support
  enable_dns_hostnames             = local.enable_dns_hostnames
  assign_generated_ipv6_cidr_block = local.assign_generated_ipv6_cidr_block
  cluster_name                     = local.cluster_name
}
