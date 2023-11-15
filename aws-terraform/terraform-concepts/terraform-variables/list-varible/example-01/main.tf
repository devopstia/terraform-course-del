provider "aws" {
  region = "us-east-1" # Set your desired AWS region here
}

# Define a list of availability zones and corresponding CIDR blocks
variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"] # Adjust the AZs as needed
}

variable "cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Adjust the CIDR blocks as needed
}

# Create a VPC
resource "aws_vpc" "example" {
  cidr_block           = "10.0.0.0/16" # Adjust the VPC CIDR block as needed
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create public subnets in each availability zone with corresponding CIDR blocks
resource "aws_subnet" "public_a" {
  cidr_block        = var.cidr_blocks[0]
  vpc_id            = aws_vpc.example.id
  availability_zone = var.availability_zones[0]

  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet in us-east-1a"
    Environment = "Production"
  }
}

resource "aws_subnet" "public_b" {
  cidr_block        = var.cidr_blocks[1]
  vpc_id            = aws_vpc.example.id
  availability_zone = var.availability_zones[1]

  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet in us-east-1b"
    Environment = "Production"
  }
}

resource "aws_subnet" "public_c" {
  cidr_block        = var.cidr_blocks[2]
  vpc_id            = aws_vpc.example.id
  availability_zone = var.availability_zones[2]

  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet in us-east-1c"
    Environment = "Production"
  }
}
