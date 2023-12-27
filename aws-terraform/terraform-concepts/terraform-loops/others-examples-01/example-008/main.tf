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
  for_each = { for idx, cidr in var.public_subnet_cidr_blocks : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], each.key)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = { for idx, cidr in var.private_subnet_cidr_blocks : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(["us-east-1a", "us-east-1b", "us-east-1c"], each.key)
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${each.key}"
  }
}

# output "private_subnet_ids" {
#   value = aws_subnet.private_subnets[*].id
# }

# output "public_subnet_ids" {
#   value = aws_subnet.public_subnets[*].id
# }

output "private_subnet_ids" {
  value = [for subnet_key, subnet in aws_subnet.private_subnets : subnet.id]
}

output "public_subnet_ids" {
  value = [for subnet_key, subnet in aws_subnet.public_subnets : subnet.id]
}

