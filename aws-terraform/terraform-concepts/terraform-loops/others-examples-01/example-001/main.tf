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
  default = [
    {
      cidr_block = "10.5.0.0/16",
      tags = {
        Name        = "MyVPC1",
        Environment = "Production"
      }
    },
    {
      cidr_block = "10.10.0.0/16",
      tags = {
        Name        = "MyVPC2",
        Environment = "Development"
      }
    }
  ]
}

resource "aws_vpc" "example" {
  count      = length(var.vpcs)
  cidr_block = var.vpcs[count.index].cidr_block

  tags = var.vpcs[count.index].tags
}

output "vpc_ids" {
  value = [for vpc_ids in aws_vpc.example : vpc.vpc_ids]
}

output "vpc_arn" {
  value = [for vpn_arn in aws_vpc.example : vpc.vpn_arn]
}