## Terraform block
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
  region = "us-east-1"
}

data "terraform_remote_state" "vpc_state" {
  backend = "s3"
  config = {
    bucket = "2560-dev-del-backend"
    key    = "vpc-test/terraform.tfstate"
    region = "us-east-1"
  }
}

output "vpc_id" {
  value = data.terraform_remote_state.vpc_state.outputs.vpc_id
}

output "public_subnets" {
  value = data.terraform_remote_state.vpc_state.outputs.public_subnets
}

output "private_subnets" {
  value = data.terraform_remote_state.vpc_state.outputs.private_subnets
}

output "private_cidrs" {
  value = data.terraform_remote_state.vpc_state.outputs.private_cidrs
}

output "public_cidrs" {
  value = data.terraform_remote_state.vpc_state.outputs.public_cidrs
}

