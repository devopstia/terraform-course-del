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

resource "aws_vpc" "main" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "2560-dev-del-vpc"
  }
}

resource "aws_subnet" "private_subnets" {
  count = 3

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"], count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnets" {
  count = 3

  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(["10.10.4.0/24", "10.10.5.0/24", "10.10.6.0/24"], count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
