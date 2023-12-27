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


variable "vpc_name" {
  type    = string
  default = "my-vpc"
}

variable "subnet_names" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

resource "aws_vpc" "example" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Environment = "dev"
  }
}

resource "aws_subnet" "example" {
  for_each = { for idx, subnet_names in var.subnet_names : idx => subnet_names }

  cidr_block        = "10.10.${each.key}.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.example.id

  tags = {
    Name        = each.value
    Environment = "dev"
  }
}

output "vpc_info" {
  value = {
    id         = aws_vpc.example.id
    cidr_block = aws_vpc.example.cidr_block
    tags       = aws_vpc.example.tags
  }
}

output "subnet_info" {
  value = { for name, subnet in aws_subnet.example : name => {
    id                = subnet.id
    cidr_block        = subnet.cidr_block
    availability_zone = subnet.availability_zone
    tags              = subnet.tags
  } }
}