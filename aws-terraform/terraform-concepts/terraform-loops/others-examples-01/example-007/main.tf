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

variable "public_subnet_cidr_blocks" {
  default = [
    "10.10.4.0/24",
    "10.10.5.0/24",
    "10.10.6.0/24",
  ]
}

variable "private_subnet_cidr_blocks" {
  default = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24",
  ]
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${var.public_subnet_cidr_blocks[count.index]}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidr_blocks)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_cidr_blocks[count.index]
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${var.private_subnet_cidr_blocks[count.index]}"
  }
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}
