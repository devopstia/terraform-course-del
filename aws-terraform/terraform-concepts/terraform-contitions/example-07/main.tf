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


variable "create_instance" {
  description = "Set to true to create the EC2 instance, false to skip creation."
  type        = bool
  default     = false # Default to skip instance creation.
}

variable "environment" {
  description = "The environment in which to create the EC2 instance."
  type        = string
  default     = "development"
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

resource "aws_instance" "example" {
  count = var.create_instance && var.environment == "production" && var.instance_type == "t2.micro" ? 1 : 0

  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = var.instance_type
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}
