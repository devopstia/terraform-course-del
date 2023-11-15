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
resource "aws_subnet" "public" {
  count = length(var.availability_zones)

  cidr_block        = var.cidr_blocks[count.index]
  vpc_id            = aws_vpc.example.id
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name        = "Public Subnet ${count.index + 1}"
    Environment = "Production"
  }
}
