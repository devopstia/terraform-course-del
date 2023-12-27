terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "vpcs" {
  default = ["10.5.0.0/16", "10.10.0.0/16"]
}

resource "aws_vpc" "example" {
  for_each   = toset(var.vpcs)
  cidr_block = each.value
}

# this will not work because we are not using count argument
# output "vpc_ids" {
#   value      = aws_vpc.example[*].id
# }

output "vpc_ids" {
  value = [for vpc_ids in aws_vpc.example : vpc.vpc_ids]
}

output "vpc_arn" {
  value = [for vpn_arn in aws_vpc.example : vpc.vpn_arn]
}