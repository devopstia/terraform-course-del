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
  count      = length(var.vpcs)
  cidr_block = var.vpcs[count.index]
}

resource "aws_internet_gateway" "example" {
  count = length(aws_vpc.example)
}

output "vpc_ids" {
  value = aws_vpc.example[*].id
}
