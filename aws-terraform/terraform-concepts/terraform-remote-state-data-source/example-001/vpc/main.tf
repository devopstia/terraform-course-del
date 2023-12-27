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

terraform {
  backend "s3" {
    bucket = "2560-dev-del-backend"
    # dynamodb_table = "2560-dev-del-backend-lock"
    key    = "vpc-test/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_vpc" "example_vpc" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_subnet" "example_subnet1" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.10.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-01"
  }
}

resource "aws_subnet" "example_subnet2" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = "10.10.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-02"
  }
}

output "vpc_id" {
  value = aws_vpc.example_vpc.id
}

output "subnet1_id" {
  value = aws_subnet.example_subnet1.id
}

output "subnet2_id" {
  value = aws_subnet.example_subnet2.id
}
