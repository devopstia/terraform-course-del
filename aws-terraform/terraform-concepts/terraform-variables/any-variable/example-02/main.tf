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

variable "ec2_instance_config" {
  type        = any
  description = "Configuration for EC2 instance"
  default = {
    ec2_settings = {
      ami           = "ami-0fc5d935ebf8bc3bc"
      instance_type = ["t2.micro", "t2.medium"]
      key_name      = "terraform-aws"
    }
    vpc_settings = {
      vpc_cidr_block       = "10.10.0.0/16"
      enable_dns_support   = true
      enable_dns_hostnames = true
      availability_zones   = ["us-east-1a", "us-east-1b"]
      subnet_cidr_blocks   = ["10.10.1.0/24", "10.10.2.0/24"]
    }
    tags = {
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "development"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    }
  }
}

resource "aws_vpc" "example_vpc" {
  cidr_block           = var.ec2_instance_config["vpc_settings"]["vpc_cidr_block"]
  enable_dns_support   = var.ec2_instance_config["vpc_settings"]["enable_dns_support"]
  enable_dns_hostnames = var.ec2_instance_config["vpc_settings"]["enable_dns_hostnames"]
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = var.ec2_instance_config["vpc_settings"]["subnet_cidr_blocks"][0]
  availability_zone       = var.ec2_instance_config["vpc_settings"]["availability_zones"][0]
  map_public_ip_on_launch = true
  tags = {
    Name = "MyPublicSubnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example_igw.id
  }
  tags = {
    Name = "PublicSubnetRouteTable"
  }
}

resource "aws_route_table_association" "public_01" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "example_sg" {
  name        = "example_sg"
  description = "Example security group for EC2 instance"
  vpc_id      = aws_vpc.example_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami                    = var.ec2_instance_config["ec2_settings"]["ami"]
  instance_type          = var.ec2_instance_config["ec2_settings"]["instance_type"][0]
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.ec2_instance_config["ec2_settings"]["key_name"]
  vpc_security_group_ids = [aws_security_group.example_sg.id]
  tags                   = var.ec2_instance_config["tags"]
}

