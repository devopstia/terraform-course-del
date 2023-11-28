
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"
}

locals {
  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "cluster_name" {
  type    = string
  default = "2560-development-del"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = format("%s-%s-%s-vpc", local.tags["id"], local.tags["environment"], local.tags["project"])
  cidr = "10.10.0.0/16"

  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets    = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets     = ["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = false

  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"           = 1
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = local.tags
}

