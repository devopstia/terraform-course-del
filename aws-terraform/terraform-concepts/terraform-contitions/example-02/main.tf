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
  default     = true # Set to false to skip instance creation by default.
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0 # Use the variable to conditionally create the instance.

  ami                    = var.create_instance ? "ami-0fc5d935ebf8bc3bc" : null
  instance_type          = var.create_instance ? "t2.micro" : null
  key_name               = var.create_instance ? "terraform-aws" : null
  vpc_security_group_ids = var.create_instance ? ["sg-0c51540c60857b7ed"] : []
  subnet_id              = var.create_instance ? "subnet-096d45c28d9fb4c14" : null

  root_block_device {
    volume_size = var.create_instance ? "10" : null
  }

  tags = var.create_instance ? {
    Name      = "vm"
    Create_By = "Terraform"
  } : {}
}
